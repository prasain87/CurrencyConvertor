//
//  Conversion.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 26/04/24.
//

import Foundation

struct Conversion {
    let currency: Currency
    let value: String
}

extension Conversion: Identifiable {
    var id: String {
        currency.code
    }
}
