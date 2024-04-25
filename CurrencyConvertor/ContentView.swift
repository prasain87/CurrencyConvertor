//
//  ContentView.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 23/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = CurrencyModel(service: Service())
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some View {
        NavigationStack {
            VStack {
                if let error = errorWrapper {
                    ErrorView(errorWrapper: error) {
                        errorWrapper = nil
                        updateData()
                    }
                } else if model.isShowProgress() {
                    ProgressView()
                    Text("Fetching data...")
                        .font(.caption)
                } else {
                    ConverterView(model: model)
                        .padding(10)
                    Spacer()
                }
            }
            .navigationTitle("Currency Convertor")
        }
        .onAppear {
            updateData()
        }
    }
    
    func updateData() {
        Task {
            do {
                try await model.updateCurrencylist()
            } catch {
                errorWrapper = ErrorWrapper(error: error, guidance: "This seems to be a network error. Please try again after sometime.")
            }
        }
    }
}

#Preview {
    ContentView()
}
