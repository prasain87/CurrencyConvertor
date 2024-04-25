//
//  CurrencyModel.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 24/04/24.
//

import Foundation
import Combine

class CurrencyModel: ObservableObject {
    @Published var exchangeRates: ExchangeRates?
    @Published var destinationCurrency: String = "INR"
    @Published var sourceCurrency = "USD"
    @Published var value: String = ""
    @Published var convertedValue: String = ""
    
    let service: CurrencyService
    
    private var cancellable = Set<AnyCancellable>()
    
    init(service: CurrencyService) {
        self.service = service
        
        $value
            .removeDuplicates()
            .sink { [weak self] value in
                do {
                    try self?.convertToDestination(value: value, rates: 1)
                } catch {
                    print(error)
                }
            }
            .store(in: &cancellable)
        
        $convertedValue
            .removeDuplicates()
            .sink { [weak self] val in
                do {
                    try self?.convertToSource(value: val, rates: 1)
                } catch {
                    print(error)
                }
            }
            .store(in: &cancellable)
    }
    
    func convertToDestination(value: String, rates: Double) throws {
        guard !value.isEmpty else {
            self.convertedValue = ""
            return
        }
        guard let value = Double(value) else {
            throw ConversionError.invalidValue
        }
        convertedValue = String(value * rates)
    }
    
    func convertToSource(value: String, rates: Double) throws {
        guard !value.isEmpty else {
            self.value = ""
            return
        }
        guard let value = Double(value) else {
            throw ConversionError.invalidValue
        }
        self.value = String(value / rates)
    }
}

enum ConversionError: Error {
    case invalidValue
}
