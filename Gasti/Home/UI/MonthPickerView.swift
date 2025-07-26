//
//  MonthPickerView.swift
//  Gasti
//
//  Created by Constanza Lancieri on 21/07/2025.
//

import SwiftUI

struct MonthPickerView: View {
    @State private var selectedMonthIndex: Int = Calendar.current.component(.month, from: Date()) - 1

    private var allMonths: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_AR")
        return formatter.monthSymbols.map { $0.capitalized }
    }

    var body: some View {
        Menu {
            ForEach(0..<allMonths.count, id: \.self) { index in
                Button(action: {
                    selectedMonthIndex = index
                }) {
                    Text(allMonths[index])
                }
            }
        } label: {
            HStack(spacing: 4) {
                Text(allMonths[selectedMonthIndex])
                    .font(.headline)
                Image(systemName: "chevron.down")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.clear))
            .cornerRadius(14)
            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }
}

struct MonthPickerView_Previews: PreviewProvider {
    static var previews: some View {
        MonthPickerView()
    }
}
