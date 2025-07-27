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
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                NumPadButton(value: "1", amount: $amount)
                NumPadButton(value: "2", amount: $amount)
                NumPadButton(value: "3", amount: $amount)
            }
            HStack(spacing: 8) {
                NumPadButton(value: "4", amount: $amount)
                NumPadButton(value: "5", amount: $amount)
                NumPadButton(value: "6", amount: $amount)
            }
            HStack(spacing: 8) {
                NumPadButton(value: "7", amount: $amount)
                NumPadButton(value: "8", amount: $amount)
                NumPadButton(value: "9", amount: $amount)
            }
            HStack(spacing: 8) {
                NumPadButton(value: ".", amount: $amount)
                NumPadButton(value: "0", amount: $amount)
                Button(action: { 
                    if !amount.isEmpty {
                        amount = String(amount.dropLast()) 
                    }
                }) {
                    Image(systemName: "delete.left.fill")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                        .cornerRadius(25)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct NumPadButton: View {
    let value: String
    @Binding var amount: String
    
    private func handleTap() {
        if value == "." {
            if !amount.contains(".") {
                amount += value
            }
        } else {
            // Si es el primer dígito y es cero, no hacer nada
            if amount == "0" && value != "." {
                amount = value
            } else {
                amount += value
            }
        }
    }
    
    var body: some View {
        Button(action: handleTap) {
            Text(value)
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                .cornerRadius(25)
        }
    }
}

#Preview {
    CustomNumPad(amount: .constant(""))
        .preferredColorScheme(.dark)
        .frame(height: 225)
}
