//
//  ExpenseType.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import SwiftUI

enum ExpenseType: String, CaseIterable, Identifiable, Codable {
    case fixed = "Fijo"
    case variable = "Variable"
    case saving = "Ahorro"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .fixed:
            return "lock"
        case .variable:
            return "chart.line.uptrend.xyaxis"
        case .saving:
            return "banknote"
        }
    }
    
    var color: Color {
        switch self {
        case .fixed:
            return .blue
        case .variable:
            return .orange
        case .saving:
            return Color(red: 0.6, green: 0.4, blue: 0.8)
        }
    }
    
    var emoji: String {
        switch self {
        case .fixed:
            return "🔒"
        case .variable:
            return "📊"
        case .saving:
            return "🏦"
        }
    }
} 
