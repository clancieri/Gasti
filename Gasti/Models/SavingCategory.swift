//
//  SavingCategory.swift
//  Gasti
//
//  Created by Constanza Lancieri on 2025-05-11.
//

import SwiftUI

enum SavingCategory: String, CaseIterable, Identifiable, Codable {
    case inversiones = "Inversiones"
    case dolares = "Dolares"
    case vacaciones = "Vacaciones"
    case auto = "Auto"
    case casa = "Casa"
    
    var id: String { rawValue }
    
    var emoji: String {
        switch self {
        case .inversiones: return "📈"
        case .dolares: return "💵"
        case .vacaciones: return "🏖️"
        case .auto: return "🚗"
        case .casa: return "🏠"
        }
    }
    
    var color: Color {
        switch self {
        case .inversiones: return .purple
        case .dolares: return .green
        case .vacaciones: return .orange
        case .auto: return .blue
        case .casa: return .yellow
        }
    }
} 