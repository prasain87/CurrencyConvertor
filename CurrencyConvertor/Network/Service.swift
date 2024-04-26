//
//  Service.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import Foundation

class Service: CurrencyService {
    let keyLastDataLoadTimestamp = "keyLastDataLoadTimestamp"
    var dataLoadTimestamp: Double {
        get {
            UserDefaults.standard.double(forKey: keyLastDataLoadTimestamp)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: keyLastDataLoadTimestamp)
            UserDefaults.standard.synchronize()
        }
    }
    
    let networkSetvice: NetworkServiceProtocol
    
    init(networkSetvice: NetworkServiceProtocol) {
        self.networkSetvice = networkSetvice
    }
    
    func fetchCurrencyList() async throws -> [String: String] {
        guard let url = API.currencies.url else {
            throw APIError.invalidUrl
        }
        let cachePolicy: URLRequest.CachePolicy = cachePolicy()
        let request = URLRequest(url: url, cachePolicy: cachePolicy)
        let data: [String: String] = try await networkSetvice.data(request: request)
        return data
    }
    
    func fetchExchangeRates(baseCurrencyCode: String) async throws -> ExchangeRates {
        guard let url = API.exchangeRates(base: baseCurrencyCode).url else {
            throw APIError.invalidUrl
        }
        let cachePolicy: URLRequest.CachePolicy = cachePolicy()
        let request = URLRequest(url: url, cachePolicy: cachePolicy)
        let data: ExchangeRates = try await networkSetvice.data(request: request)
        return data
    }
    
    func cachePolicy() -> URLRequest.CachePolicy {
        canLoadFromRemote() ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad
    }
    
    func canLoadFromRemote() -> Bool {
        guard dataLoadTimestamp != 0 else { return true }
        let diffInMins = Date().timeIntervalSince(Date(timeIntervalSince1970: dataLoadTimestamp)) / 60
        return diffInMins >= 30
    }
    
    func markLoadFromRemoteComplete() {
        dataLoadTimestamp = Date().timeIntervalSince1970
    }
}

protocol CurrencyService {
    func fetchCurrencyList() async throws -> [String: String]
    func fetchExchangeRates(baseCurrencyCode: String) async throws -> ExchangeRates
    func canLoadFromRemote() -> Bool
    func markLoadFromRemoteComplete()
}
