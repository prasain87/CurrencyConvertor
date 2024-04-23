//
//  ConvertorView.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import SwiftUI

struct ConverterView: View {
    @State var sourceVal: String = ""
    @State var destVal: String = ""
    @State var sourceCurrency: String = "INR"
    @State var destCurrency: String = "USD"
    
    @FocusState private var focusedField: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("From")
            CurrencyInputView(value: $sourceVal, selectedCurrency: $sourceCurrency) {
                // TODO:- show bottom-sheet for source currency selection
            }
            .onAppear(perform: {
                focusedField = true
            })
            .focused($focusedField)
            Text("To")
            CurrencyInputView(value: $destVal, selectedCurrency: $destCurrency) {
                // TODO:- show bottom-sheet for destination currency selection
            }
        }
    }
}
