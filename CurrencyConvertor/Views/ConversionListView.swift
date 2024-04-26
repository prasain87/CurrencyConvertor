//
//  ConversionListView.swift
//  CurrencyConvertor
//
//  Created by Prateek Sujaina on 26/04/24.
//

import SwiftUI

struct ConversionListView: View {
    @Binding var list: [Conversion]
    
    var body: some View {
        List(list) { item in
            HStack {
                Text("\(item.currency.name)")
                Spacer()
                Text("\(item.value)")
            }
        }
        .listStyle(.plain)
    }
}
