//
//  Service.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import Foundation

class Service: CurrencyService, NetworkService {
    func fetchCurrencyList() async throws -> [String: String] {
        guard let url = API.currencies.url else {
            throw APIError.invalidUrl
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let data: ([String: String], URLResponse) = try await data(request: request)
        return data.0
    }
    
    func fetchExchangeRates(baseCurrencyCode: String) async throws -> ExchangeRates {
        guard let url = API.exchangeRates(base: baseCurrencyCode).url else {
            throw APIError.invalidUrl
        }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let data: (ExchangeRates, URLResponse) = try await data(request: request)
        return data.0
    }
    
    func data<T: Decodable>(request: URLRequest) async throws -> (T, URLResponse) {
        let (data, response) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return (decoded, response)
    }
}

protocol CurrencyService {
    func fetchCurrencyList() async throws -> [String: String]
    func fetchExchangeRates(baseCurrencyCode: String) async throws -> ExchangeRates
}

protocol NetworkService {
    func data<T: Decodable>(request: URLRequest) async throws -> (T, URLResponse)
}
