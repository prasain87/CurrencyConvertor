//
//  CurrencyModel.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 24/04/24.
//

import Foundation
import Combine

class CurrencyModel: ObservableObject {
    private static let defaultSourceCurrency = "USD"
    
    @Published private(set) var exchangeRates: ExchangeRates = ExchangeRates(base: defaultSourceCurrency, rates: [:])
    @Published var destinationCurrency: String = "" {
        didSet {
            self.convertToDestination(value, currencyCode: self.destinationCurrency)
        }
    }
    @Published var sourceCurrency = defaultSourceCurrency
    @Published var value: String = ""
    @Published var convertedValue: String = ""
    
    private(set) var currencyList: [Currency] = []
    
    let service: CurrencyService
    
    private var cancellable = Set<AnyCancellable>()
    
    init(service: CurrencyService) {
        self.service = service
        $value
            .removeDuplicates()
            .sink { [weak self] value in
                guard let `self` else { return }
                self.convertToDestination(value, currencyCode: self.destinationCurrency)
            }
            .store(in: &cancellable)
        
        $convertedValue
            .removeDuplicates()
            .sink { [weak self] val in
                guard let `self` else { return }
                self.convertToSource(val, currencyCode: self.destinationCurrency)
            }
            .store(in: &cancellable)        
    }
    
    @MainActor
    func updateCurrencylist() async throws {
        exchangeRates = try await service.fetchExchangeRates(baseCurrencyCode: sourceCurrency)
        // Need to show error. This data block the user.
        if exchangeRates.rates.isEmpty {
            throw APIError.noData
        }

        currencyList = try await fetchCurrencyList()
        // Need to show error. This data block the user.
        if currencyList.isEmpty {
            throw APIError.noData
        }
        if let first = currencyList.first {
            destinationCurrency = first.code
        }
    }
    
    func fetchCurrencyList() async throws -> [Currency] {
        return try await service.fetchCurrencyList()
            .map({ Currency(name: $1, code: $0) })
            .sorted(by: { $0.name < $1.name })
    }
    
    func isShowProgress() -> Bool {
        currencyList.isEmpty
    }
    
}

extension CurrencyModel {
    func convert(_ value: String, currencyCode: String, toSource: Bool = false) throws -> String {
        guard !value.isEmpty else {
            return ""
        }
        guard let value = Double(value) else {
            throw ConversionError.invalidValue
        }
        guard let rates = exchangeRates.rates[currencyCode] else {
            throw ConversionError.exchangeRateNotFound(currencyCode)
        }
        return if toSource {
            String(value / rates)
        } else {
            String(value * rates)
        }
    }
    
    func convertToDestination(_ value: String, currencyCode: String) {
        do {
            convertedValue = try self.convert(value, currencyCode: destinationCurrency)
        } catch {
            print(error)
        }
    }
    
    func convertToSource(_ value: String, currencyCode: String) {
        do {
            self.value = try self.convert(value, currencyCode: currencyCode, toSource: true)
        } catch {
            print(error)
        }
    }
}
