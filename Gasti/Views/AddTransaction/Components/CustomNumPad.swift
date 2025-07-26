//
//  CustomNumPad.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import SwiftUI

struct CustomNumPad: View {
    @Binding var amount: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                NumPadButton(value: "1", amount: $amount)
                NumPadButton(value: "2", amount: $amount)
                NumPadButton(value: "3", amount: $amount)
            }
            HStack(spacing: 10) {
                NumPadButton(value: "4", amount: $amount)
                NumPadButton(value: "5", amount: $amount)
                NumPadButton(value: "6", amount: $amount)
            }
            HStack(spacing: 10) {
                NumPadButton(value: "7", amount: $amount)
                NumPadButton(value: "8", amount: $amount)
                NumPadButton(value: "9", amount: $amount)
            }
            HStack(spacing: 10) {
                NumPadButton(value: ",", amount: $amount)
                NumPadButton(value: "0", amount: $amount)
                Button(action: { amount = String(amount.dropLast()) }) {
                    Image(systemName: "delete.left")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemGray4))
                        .cornerRadius(16)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
}

struct NumPadButton: View {
    let value: String
    @Binding var amount: String
    
    var body: some View {
        Button(action: { amount += value }) {
            Text(value)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGray4))
                .cornerRadius(16)
        }
    }
}