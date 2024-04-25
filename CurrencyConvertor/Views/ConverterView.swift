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
            // Source currency text-field
            // passed nil action to disable it because base parameter not supported for API calls with free account
            CurrencyInputView(value: $model.value, selectedCurrency: $model.sourceCurrency, action: nil)
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
