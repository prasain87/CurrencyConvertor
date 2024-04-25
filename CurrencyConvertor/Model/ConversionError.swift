//
//  ConversionError.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 25/04/24.
//

import Foundation

enum ConversionError: Error {
    case invalidValue
    case exchangeRateNotFound(String)
}

extension ConversionError {
    var localizedDescription: String {
        return switch self {
        case .invalidValue:
            "Invalid Input! Please enter only a numeric value."
        case .exchangeRateNotFound(let str):
            "Conversion rates not found for \(str)"
        }
    }
}
