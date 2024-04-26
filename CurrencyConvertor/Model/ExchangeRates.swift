//
//  ExchangeRates.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 24/04/24.
//

import Foundation

struct ExchangeRates: Codable {
//    let timestamp: Double
//    let base: String
    let rates: [String: Double]
}
