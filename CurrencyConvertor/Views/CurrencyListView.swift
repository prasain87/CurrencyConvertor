//
//  CurrencyListView.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 25/04/24.
//

import SwiftUI

struct CurrencyListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var selectedCurrency: String
    let currencyList: [Currency]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select the currency")
                .font(.title)
                .padding(10)
                .padding([.leading, .trailing, .top], 10)
            List(currencyList) { item in
                Text(item.name)
                    .listRowBackground(item.code == selectedCurrency ? Color.blue.opacity(0.2) : nil)
                    .onTapGesture {
                        selectedCurrency = item.code
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .listStyle(.plain)
        }
    }
}
