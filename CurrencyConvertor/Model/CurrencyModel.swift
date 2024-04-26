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
    @Published var sourceCurrency = Locale.current.currency?.identifier ?? defaultSourceCurrency
    @Published var inputValue: String = ""
    @Published var conversionList: [Conversion] = []
    
    private(set) var currencyList: [Currency] = []
    
    let service: CurrencyService
    
    private var cancellable = Set<AnyCancellable>()
    
    init(service: CurrencyService) {
        self.service = service
        $inputValue
            .removeDuplicates()
            .sink { [weak self] value in
                guard let `self` else { return }
                self.updateConversions(input: value, for: self.sourceCurrency)
            }
            .store(in: &cancellable)
        
        $sourceCurrency
            .removeDuplicates()
            .sink { [weak self] code in
                guard let `self`, !self.inputValue.isEmpty else { return }
                self.updateConversions(input: self.inputValue, for: code)
            }
            .store(in: &cancellable)
    }
    
    @MainActor
    func updateCurrencylist() async throws {
        currencyList = try await fetchCurrencyList()
        // Need to show error. This data block the user.
        if currencyList.isEmpty {
            throw APIError.noData
        }

        exchangeRates = try await service.fetchExchangeRates(baseCurrencyCode: CurrencyModel.defaultSourceCurrency)
        // Need to show error. This data block the user.
        if exchangeRates.rates.isEmpty {
            throw APIError.noData
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
    func updateConversions(input: String, for code: String) {
        if input.isEmpty {
            self.conversionList.removeAll()
        } else {
            self.conversionList = self.currencyList
                .filter({$0.code != code})
                .map({
                    let conversion = try? self.convert(input, from: code, to: $0.code)
                    return Conversion(currency: $0, value: conversion ?? "")
                })
        }
    }
    
    func convert(_ value: String, from source: String, to destination: String) throws -> String {
        guard !value.isEmpty else {
            return ""
        }
        guard let value = Double(value) else {
            throw ConversionError.invalidValue
        }
        let rates_usd_src = exchangeRates.rates[safe: source] ?? 1
        let rates_usd_dst = exchangeRates.rates[safe: destination] ?? 1
        let conversion = value / rates_usd_src * rates_usd_dst
        
        return "\(conversion)"
    }
}

struct Conversion {
    let currency: Currency
    let value: String
}

extension Conversion: Identifiable {
    var id: String {
        currency.code
    }
}

extension Dictionary {
    subscript(safe key: Key) -> Value? {
        guard let val = self[key] else {
            return nil
        }
        return val
    }
}
