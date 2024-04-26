//
//  CurrencyModel.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 24/04/24.
//

import Foundation
import Combine

class CurrencyModel: ObservableObject {
    static let defaultSourceCurrency = "USD"
    
    @Published private(set) var exchangeRates: ExchangeRates = ExchangeRates(rates: [:])
    @Published var selectedCurrency = defaultSourceCurrency
    @Published var inputValue: String = ""
    @Published var conversionList: [Conversion] = []
    @Published private(set) var showLoading: Bool = true
    
    private(set) var currencyList: [Currency] = []
    
    let service: CurrencyService
    
    private var cancellable = Set<AnyCancellable>()
    
    init(service: CurrencyService) {
        self.service = service
        $inputValue
            .removeDuplicates()
            .sink { [weak self] value in
                guard let `self` else { return }
                self.updateConversions(input: value, for: self.selectedCurrency)
            }
            .store(in: &cancellable)
        
        $selectedCurrency
            .removeDuplicates()
            .sink { [weak self] code in
                guard let `self`, !self.inputValue.isEmpty else { return }
                self.updateConversions(input: self.inputValue, for: code)
                self.refreshDataIfRequired()
            }
            .store(in: &cancellable)
    }
        
    func fetchCurrencyList() async throws -> [Currency] {
        return try await service.fetchCurrencyList()
            .map({ Currency(name: $1, code: $0) })
            .sorted(by: { $0.name < $1.name })
    }
}

extension CurrencyModel {
    @MainActor
    func updateCurrencylist() async throws {
        showLoading = currencyList.isEmpty || exchangeRates.rates.isEmpty
        do {
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
            showLoading = false
        } catch {
            showLoading = false
            throw error
        }
    }

    @MainActor
    func initialFetch() async throws {
        let isRemoteFetch = service.canLoadFromRemote()
        try await updateCurrencylist()
        if isRemoteFetch {
            service.markLoadFromRemoteComplete()
        }
        
        // set local currency as selected if present in the fetched currency list
        if let localCurrency = Locale.current.currency?.identifier, currencyList.contains(where: {$0.code == localCurrency}) {
            selectedCurrency = localCurrency
        }
    }
    
    func refreshDataIfRequired() {
        if service.canLoadFromRemote() {
            Task {
                do {
                    try await updateCurrencylist()
                    // This saves the timeStamp for the latest refresh from remote
                    service.markLoadFromRemoteComplete()
                } catch {
                    // not throwing error as this is like a background update not user initiated so showing error at this point will confuse the user and impact the user experience
                }
            }
        }
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
        let conversion = value * (rates_usd_dst / rates_usd_src)
        
        return "\(conversion)"
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
