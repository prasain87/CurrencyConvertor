//
//  NetworkMock.swift
//  CurrencyConvertorTests
//
//  Created by Prateek Sujaina on 26/04/24.
//

import Foundation

final class NetworkMock {
    private var responseQueue: [String] = []
    
    func appendResponse(data: String) {
        responseQueue.append(data)
    }
    
    func reset() {
        responseQueue.removeAll()
    }
}

extension NetworkMock: NetworkServiceProtocol {
    func data<T>(request: URLRequest) async throws -> T where T : Decodable {
        guard !responseQueue.isEmpty else {
            throw NetworkMockError.responseNotAvailable
        }
        guard let data = responseQueue.removeFirst().data(using: .utf8) else {
            throw NetworkMockError.invalidData
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum NetworkMockError: Error {
    case responseNotAvailable
    case invalidData
}
