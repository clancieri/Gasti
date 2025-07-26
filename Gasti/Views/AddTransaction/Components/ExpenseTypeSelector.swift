//
//  ExpenseTypeSelector.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import SwiftUI

struct ExpenseTypeSelector: View {
    @Binding var selectedType: ExpenseType
    
    var body: some View {
        Picker("Tipo de gasto", selection: $selectedType) {
            ForEach(ExpenseType.allCases) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(.segmented)
    }
}