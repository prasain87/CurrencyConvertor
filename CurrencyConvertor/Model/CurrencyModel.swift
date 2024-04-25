//
//  CurrencyModel.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 24/04/24.
//

import Foundation
import Combine

class CurrencyModel: ObservableObject {
    @Published var exchangeRates: ExchangeRates?
    @Published var destinationCurrency: String = ""
    @Published var sourceCurrency = "USD"
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
                do {
                    try self?.convertToDestination(value: value, rates: 1)
                } catch {
                    print(error)
                }
            }
            .store(in: &cancellable)
        
        $convertedValue
            .removeDuplicates()
            .sink { [weak self] val in
                do {
                    try self?.convertToSource(value: val, rates: 1)
                } catch {
                    print(error)
                }
            }
            .store(in: &cancellable)
    }
    
    @MainActor
    func updateCurrencylist() async {
        do {
            currencyList = try await fetchCurrencyList()
            if let first = currencyList.first {
                destinationCurrency = first.code
            }
            
            exchangeRates = try await service.fetchExchangeRates(baseCurrencyCode: sourceCurrency)
        } catch {
            print(error)
        }
    }
    
    func fetchCurrencyList() async throws -> [Currency] {
        return try await service.fetchCurrencyList()
            .map({ Currency(name: $1, code: $0) })
            .sorted(using: SortDescriptor(\.code, comparator: .lexical, order: .forward))
    }
    
    func convertToDestination(value: String, rates: Double) throws {
        guard !value.isEmpty else {
            self.convertedValue = ""
            return
        }
        guard let value = Double(value) else {
            throw ConversionError.invalidValue
        }
        convertedValue = String(value * rates)
    }
    
    func convertToSource(value: String, rates: Double) throws {
        guard !value.isEmpty else {
            self.value = ""
            return
        }
        guard let value = Double(value) else {
            throw ConversionError.invalidValue
        }
        self.value = String(value / rates)
    }
}

enum ConversionError: Error {
    case invalidValue
}
