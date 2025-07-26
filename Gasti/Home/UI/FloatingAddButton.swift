
//
//  FloatingAddButton.swift
//  Gasti
//
//  Created by Constanza Lancieri on 10/05/2025.
//

import SwiftUI

struct FloatingAddButton: View {
    @Binding var showAddExpense: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showAddExpense = true
                }) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.3, green: 0.2, blue: 0.6))
                            .frame(width: 60, height: 60)
                            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.trailing, 24)
                .padding(.bottom, 80) // Más arriba para no tapar la tabbar
            }
        }
       // .ignoresSafeArea()
    }
}
