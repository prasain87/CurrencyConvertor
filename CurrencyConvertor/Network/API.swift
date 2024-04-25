//
//  API.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 24/04/24.
//

import Foundation

enum API {
    private static let app_id = "f9a0725f9d8449ab8f98358e91d6f523"
    private static let host = "openexchangerates.org"
    
    case currencies
    case exchangeRates(base: String)
}

extension API {
    var url: URL? {
        var cmp = URLComponents()
        cmp.scheme = "https"
        cmp.host = API.host
        cmp.queryItems = [
            URLQueryItem(name: "app_id", value: API.app_id)
        ]
        switch self {
        case .currencies:
            cmp.path = "/api/currencies.json"
        case .exchangeRates(let base):
            cmp.path = "/api/latest.json"
            cmp.queryItems?.append(URLQueryItem(name: "base", value: base))
        }
        
        return cmp.url
    }
}
