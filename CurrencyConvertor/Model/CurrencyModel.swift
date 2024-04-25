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
    @Published var destinationCurrency: String = ""
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
                do {
                    self.convertedValue = try self.convert(value)
                } catch {
                    print(error)
                }
            }
            .store(in: &cancellable)
        
        $convertedValue
            .removeDuplicates()
            .sink { [weak self] val in
                guard let `self` else { return }
                do {
                    self.value = try self.convert(val, toSource: true)
                } catch {
                    print(error)
                }
            }
            .store(in: &cancellable)
        
        $destinationCurrency
            .removeDuplicates()
            .sink { [weak self] value in
                guard let `self` else { return }
                do {
                    self.convertedValue = try self.convert(self.value)
                } catch {
                    print(error)
                }
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
    
    func convert(_ value: String, toSource: Bool = false) throws -> String {
        guard !value.isEmpty else {
            return ""
        }
        guard let value = Double(value) else {
            throw ConversionError.invalidValue
        }
        guard let rates = exchangeRates.rates[self.destinationCurrency] else {
            throw ConversionError.exchangeRateNotFound(self.destinationCurrency)
        }
        return if toSource {
            String(convertToSource(value, rates))
        } else {
            String(convertToDestination(value, rates))
        }
    }
    
    func convertToDestination(_ value: Double, _ rates: Double) -> Double {
        return value * rates
    }
    
    func convertToSource(_ value: Double, _ rates: Double) -> Double {
        return value / rates
    }
}
