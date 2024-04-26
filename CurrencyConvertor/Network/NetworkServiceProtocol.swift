//
//  NetworkServiceProtocol.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 26/04/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func data<T: Decodable>(request: URLRequest) async throws -> T
}
