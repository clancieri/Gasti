//
//  DatePickerSheet.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import SwiftUI

struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            DatePicker(
                "Seleccionar fecha",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding()
            
            Button("Aceptar") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}