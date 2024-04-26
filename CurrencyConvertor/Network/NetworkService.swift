//
//  NetworkService.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 26/04/24.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    func data<T: Decodable>(request: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
