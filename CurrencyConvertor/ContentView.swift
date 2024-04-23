//
//  ContentView.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(title: "Currency Convertor")
            ConverterView()
            Spacer()
        }
        .padding(10)
    }
}

#Preview {
    ContentView()
}
