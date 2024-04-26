//
//  CurrencyConvertorTests.swift
//  CurrencyConvertorTests
//
//  Created by Prateek Sujaina on 23/04/24.
//

import XCTest
@testable import CurrencyConvertor

final class CurrencyConvertorTests: XCTestCase {
    
    var networkService = NetworkMock()
    var service: Service!
    override func setUpWithError() throws {
        service = Service(networkSetvice: networkService)
    }

    override func tearDownWithError() throws {
        networkService.reset()
    }

    /// This test check whether locan currency get selected by default
    func testLocalCurrencySelected() async throws {
        networkService.appendResponse(data: currencyList)
        networkService.appendResponse(data: exchangeRates)
        let model = CurrencyModel(service: service)
        try await model.initialFetch()
        XCTAssertFalse(model.sourceCurrency == CurrencyModel.defaultSourceCurrency, "Local currency should be selected upon fetch complete!")
    }
    
    /// This test check if `conversionList` is has conversions after user input. This property is used for showing currency conversion in the UI.
    func testConversionWhenValueEntered() async throws {
        networkService.appendResponse(data: currencyList)
        networkService.appendResponse(data: exchangeRates)
        let model = CurrencyModel(service: service)
        try await model.initialFetch()
        XCTAssertTrue(model.conversionList.isEmpty, "Conversion list should be empty initially!")
        model.inputValue = "1"
        XCTAssertFalse(model.conversionList.isEmpty, "Conversion list should not be empty after user input!")
    }
    
    /// This test checks selected currency should not be shown in the conversion list.
    func testSelectedCurrencyConversion() async throws {
        networkService.appendResponse(data: currencyList)
        networkService.appendResponse(data: exchangeRates)
        let model = CurrencyModel(service: service)
        try await model.initialFetch()
        model.inputValue = "1"
        let isSelectedCurrencyConverted = model.conversionList.contains(where: {$0.id == model.sourceCurrency})
        XCTAssertFalse(isSelectedCurrencyConverted, "Selected currency should be excluded for conversion!")
    }
    
    /// This validates if the conversions are valid
    func testConversion() async throws {
        networkService.appendResponse(data: currencyList)
        networkService.appendResponse(data: exchangeRates)
        let model = CurrencyModel(service: service)
        try await model.initialFetch()
        model.inputValue = "1"
        var conversion = model.conversionList.first(where: {$0.id == "USD"})
        XCTAssertEqual(conversion!.value, String(1/83.351005), "Invalid conversion!")
        conversion = model.conversionList.first(where: {$0.id == "EUR"})
        XCTAssertEqual(conversion!.value, String(0.931464/83.351005), "Invalid conversion!")
    }
    
    /// This validates if the conversion changed with the updated input value.
    func testConversionUpdateWhenInputChanged() async throws {
        networkService.appendResponse(data: currencyList)
        networkService.appendResponse(data: exchangeRates)
        let model = CurrencyModel(service: service)
        try await model.initialFetch()
        model.inputValue = "1"
        var conversion = model.conversionList.first(where: {$0.id == "EUR"})
        XCTAssertEqual(conversion!.value, String(0.931464/83.351005), "Invalid conversion!")
        model.inputValue = "5"
        conversion = model.conversionList.first(where: {$0.id == "EUR"})
        XCTAssertEqual(conversion!.value, String(5*(0.931464/83.351005)), "Conversion not updated when input value changed!")
    }
    
    /// This validates the input value should remain unchanged when selected currency changed.
    func testInputWhenSelectedCurrencyChanged() async throws {
        networkService.appendResponse(data: currencyList)
        networkService.appendResponse(data: exchangeRates)
        let model = CurrencyModel(service: service)
        try await model.initialFetch()
        model.inputValue = "6"
        model.sourceCurrency = "EUR"
        XCTAssertEqual(model.inputValue, "6", "Input value should remain unchanged when different currency selected!")
    }
    
    /// This validates the conversion should update when defferent currency selected.
    func testConversionUpdateWhenSelectedCurrencyChangedAfterInput() async throws {
        networkService.appendResponse(data: currencyList)
        networkService.appendResponse(data: exchangeRates)
        let model = CurrencyModel(service: service)
        try await model.initialFetch()
        model.inputValue = "6"
        model.sourceCurrency = "EUR"
        XCTAssertFalse(model.conversionList.isEmpty, "Conversion list cannot be empty when selected currency changed after value entered!")
        let conversion = model.conversionList.first(where: {$0.id == "CNY"})
        XCTAssertEqual(conversion!.value, String(6*(7.2467/0.931464)), "Conversion not updated when selected currency changed!")
    }
    
    /// This test checks the conversion list should be empty initially before any value entered
    func testConversionWhenSelectedCurrencyChangedBeforeInput() async throws {
        networkService.appendResponse(data: currencyList)
        networkService.appendResponse(data: exchangeRates)
        let model = CurrencyModel(service: service)
        try await model.initialFetch()
        XCTAssertTrue(model.conversionList.isEmpty, "Conversion list should be empty initially when when no value entered!")
    }
    
    /// This test checks the conversion list should reset when input value deleted.
    func testConversionWhenInputDeleted() async throws {
        networkService.appendResponse(data: currencyList)
        networkService.appendResponse(data: exchangeRates)
        let model = CurrencyModel(service: service)
        try await model.initialFetch()
        model.inputValue = "1"
        XCTAssertFalse(model.conversionList.isEmpty, "Conversion list should not be empty after user input!")
        model.inputValue = ""
        XCTAssertTrue(model.conversionList.isEmpty, "Conversion list should be empty after input is empty!")
    }
}
