//
//  CurrencyInputView.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import SwiftUI

struct CurrencyInputView: View {
    @Binding var value: String
    @Binding var selectedCurrency: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            TextField("", text: $value)
                .font(.title2)
                .keyboardType(.numberPad)
            Button(action: {
                action()
            }, label: {
                Label(selectedCurrency, systemImage: "arrowtriangle.down.fill")
                    .foregroundStyle(.blue)
            })
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 2)
        )
        .padding(5)
    }
}
