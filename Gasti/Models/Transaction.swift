//
//  Transaction.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id = UUID()
    let title: String
    let amount: Double
    let category: ExpenseCategory
    let type: ExpenseType
    let date: Date
    let isIncome: Bool
    let description: String?
    
    init(title: String, amount: Double, category: ExpenseCategory, type: ExpenseType, isIncome: Bool = false, description: String? = nil) {
        self.title = title
        self.amount = amount
        self.category = category
        self.type = type
        self.date = Date()
        self.isIncome = isIncome
        self.description = description
    }
    
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "ARS"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount)) ?? "$\(amount)"
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
} 
