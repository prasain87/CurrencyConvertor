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
            CurrencyInputView(value: $model.inputValue, selectedCurrency: $model.selectedCurrency) {
                showCurrencyList = true
            }
                .focused($focusedField)
            ConversionListView(list: $model.conversionList)
        }
        .sheet(isPresented: $showCurrencyList) {
            CurrencyListView(selectedCurrency: $model.selectedCurrency, currencyList: model.currencyList)
                .presentationDetents([.fraction(0.8)])
                .presentationDragIndicator(.visible)
        }
        .onAppear {
            focusedField = true
        }
    }
}
