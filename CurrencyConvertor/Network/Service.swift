//
//  Service.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import Foundation

class Service: CurrencyService {
    func fetchCurrencyList() async throws -> [String: String] {
        guard let url = API.currencies.url else {
            throw APIError.invalidUrl
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([String: String].self, from: data)
        } catch {
            throw error
        }
    }
    
    func fetchExchangeRates(baseCurrencyCode: String) async throws -> ExchangeRates {
        guard let url = API.exchangeRates(base: baseCurrencyCode).url else {
            throw APIError.invalidUrl
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(ExchangeRates.self, from: data)
        } catch {
            throw error
        }
    }
}

protocol CurrencyService {
    func fetchCurrencyList() async throws -> [String: String]
    func fetchExchangeRates(baseCurrencyCode: String) async throws -> ExchangeRates
}
