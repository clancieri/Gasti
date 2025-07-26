//
//  ExpenseCategory.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import SwiftUI

enum ExpenseCategory: String, CaseIterable, Identifiable, Codable {
    case clothing = "Indumentaria"
    case entertainment = "Salida"
    case restaurant = "Restaurante"
    case supermarket = "Supermercado"
    case transport = "Transporte"
    case health = "Salud"
    case education = "Educación"
    case utilities = "Servicios"
    case other = "Otros"
    
    var id: String { rawValue }
    
    var emoji: String {
        switch self {
        case .clothing:
            return "👕"
        case .entertainment:
            return "🎮"
        case .restaurant:
            return "🍽️"
        case .supermarket:
            return "🛒"
        case .transport:
            return "🚗"
        case .health:
            return "🏥"
        case .education:
            return "📚"
        case .utilities:
            return "⚡"
        case .other:
            return "📦"
        }
    }
    
    var iconName: String {
        switch self {
        case .clothing:
            return "tshirt"
        case .entertainment:
            return "gamecontroller"
        case .restaurant:
            return "fork.knife"
        case .supermarket:
            return "cart"
        case .transport:
            return "car"
        case .health:
            return "cross"
        case .education:
            return "book"
        case .utilities:
            return "bolt"
        case .other:
            return "ellipsis.circle"
        }
    }
    
    var color: Color {
        switch self {
        case .clothing:
            return .purple
        case .entertainment:
            return .orange
        case .restaurant:
            return .red
        case .supermarket:
            return .green
        case .transport:
            return .blue
        case .health:
            return .pink
        case .education:
            return .indigo
        case .utilities:
            return .yellow
        case .other:
            return .gray
        }
    }
} 
