//
//  ConvertorView.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import SwiftUI

@MainActor
struct ConverterView: View {
    @ObservedObject var model: CurrencyModel
    @FocusState private var focusedField: Bool
    
    @State private var showCurrencyList: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            CurrencyInputView(value: $model.value, selectedCurrency: $model.sourceCurrency) {
                // TODO:- show bottom-sheet for source currency selection
            }
            .focused($focusedField)
            CurrencyInputView(value: $model.convertedValue, selectedCurrency: $model.destinationCurrency) {
                showCurrencyList = true
            }
        }
        .sheet(isPresented: $showCurrencyList) {
            CurrencyListView(selectedCurrency: $model.destinationCurrency, currencyList: model.currencyList)
        }
        .onAppear {
            focusedField = true
        }
    }
}
