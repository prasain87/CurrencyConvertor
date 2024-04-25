//
//  ErrorView.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 25/04/24.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    let action: (() -> Void)?
    
    var body: some View {
        VStack {
            Text("An error has occurred!")
                .font(.title)
                .padding(.bottom)
            Text(errorWrapper.error.localizedDescription)
                .font(.headline)
            Text(errorWrapper.guidance)
                .font(.caption)
                .padding(.top)
            if let action {
                Button("Refresh", action: action)
                    .font(.title)
                    .bold()
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}
