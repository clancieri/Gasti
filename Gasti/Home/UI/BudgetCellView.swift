//
//  BudgetCellView.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import SwiftUI

struct BudgetCellView: View {
    let type: BudgetType
    let amount: String
    
    var body: some View {
        VStack {
            Image(systemName: type.iconName)
                .padding()
            
            Spacer()
            
            Text(amount)
            
            Text(type.title)
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.32, height: 100)
        .padding()
        .background(type.backgroundColor)
        .cornerRadius(20)
    }
}
