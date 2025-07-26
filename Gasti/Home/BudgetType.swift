//
//  BudgetType.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import SwiftUI

enum BudgetType {
    case income
    case expense
    case saving
    
    var backgroundColor: Color {
        switch self {
        case .income:
            return .green
        case .expense:
            return .red
        case .saving:
            return .blue
        }
    }
    
    var iconName: String {
        switch self {
        case .income:
            return "arrow.up"
        case .expense:
            return "arrow.down"
        case .saving:
            return "banknote"
        }
    }
    
    var title: String {
        switch self {
        case .income:
            return "Ingresos"
        case .expense:
            return "Gastos"
        case .saving:
            return "Ahorros"
        }
    }
}
