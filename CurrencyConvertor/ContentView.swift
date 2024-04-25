//
//  ContentView.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = CurrencyModel(service: Service())
    
    var body: some View {
        NavigationStack {
            VStack {
                ConverterView(model: model)
                    .padding(10)
                Spacer()
            }
            .navigationTitle("Currency Convertor")
        }
        .onAppear {
            Task {
                await model.updateCurrencylist()
            }
        }
    }
}

#Preview {
    ContentView()
}
