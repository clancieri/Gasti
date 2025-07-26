//
//  IncomeCategory.swift
//  Gasti
//
//  Created by Constanza Lancieri on 2025-05-11.
//

import SwiftUI

enum IncomeCategory: String, CaseIterable, Identifiable, Codable {
    case sueldo = "Sueldo"
    case extras = "Extras"
    case aguinaldo = "Aguinaldo"
    case prestamos = "Prestamos"
    
    var id: String { rawValue }
    
    var emoji: String {
        switch self {
        case .sueldo: return "💼"
        case .extras: return "💸"
        case .aguinaldo: return "🎁"
        case .prestamos: return "🤝"
        }
    }
    
    var color: Color {
        switch self {
        case .sueldo: return .green
        case .extras: return .blue
        case .aguinaldo: return .purple
        case .prestamos: return .orange
        }
    }
} 