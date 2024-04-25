//
//  Currency.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 25/04/24.
//

import Foundation

struct Currency {
    let name: String
    let code: String
}

extension Currency: Identifiable {
    var id: String { code }
}
