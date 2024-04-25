//
//  APIError.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 24/04/24.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case noData
}

extension APIError {
    var localisedDescription: String {
        switch self {
        case .invalidUrl:
            "Url is invalid!"
        case .noData:
            "Blank data received from server."
        }
    }
}
