//
//  Service.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import Foundation

class Service: CurrencyService {
    let networkSetvice: NetworkServiceProtocol
    
    init(networkSetvice: NetworkServiceProtocol) {
        self.networkSetvice = networkSetvice
    }
    
    func fetchCurrencyList() async throws -> [String: String] {
        guard let url = API.currencies.url else {
            throw APIError.invalidUrl
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let data: [String: String] = try await networkSetvice.data(request: request)
        return data
    }
    
    func fetchExchangeRates(baseCurrencyCode: String) async throws -> ExchangeRates {
        guard let url = API.exchangeRates(base: baseCurrencyCode).url else {
            throw APIError.invalidUrl
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let data: ExchangeRates = try await networkSetvice.data(request: request)
        return data
    }
}

protocol CurrencyService {
    func fetchCurrencyList() async throws -> [String: String]
    func fetchExchangeRates(baseCurrencyCode: String) async throws -> ExchangeRates
}
