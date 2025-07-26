//
//  ExpenseViewModel.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import Foundation
import SwiftUI

@MainActor
class ExpenseViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var balance: Double = 0.0
    @Published var monthlyIncome: Double = 0.0
    @Published var monthlyExpenses: Double = 0.0
    @Published var monthlySavings: Double = 0.0
    
    private let userDefaults = UserDefaults.standard
    private let transactionsKey = "savedTransactions"
    
    init() {
        loadTransactions()
        
        // Agregar datos de ejemplo si no hay transacciones
        if transactions.isEmpty {
            addSampleData()
        }
        
        updateBalance()
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        saveTransactions()
        updateBalance()
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        transactions.removeAll { $0.id == transaction.id }
        saveTransactions()
        updateBalance()
    }
    
    private func updateBalance() {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())
        
        let monthlyTransactions = transactions.filter { transaction in
            let transactionMonth = Calendar.current.component(.month, from: transaction.date)
            let transactionYear = Calendar.current.component(.year, from: transaction.date)
            return transactionMonth == currentMonth && transactionYear == currentYear
        }
        
        monthlyIncome = monthlyTransactions
            .filter { $0.isIncome }
            .reduce(0) { $0 + $1.amount }
        
        monthlyExpenses = monthlyTransactions
            .filter { !$0.isIncome && $0.type != .saving }
            .reduce(0) { $0 + $1.amount }
        
        monthlySavings = monthlyTransactions
            .filter { $0.type == .saving }
            .reduce(0) { $0 + $1.amount }
        
        balance = monthlyIncome - monthlyExpenses
    }
    
    private func saveTransactions() {
        if let encoded = try? JSONEncoder().encode(transactions) {
            userDefaults.set(encoded, forKey: transactionsKey)
        }
    }
    
    private func loadTransactions() {
        if let data = userDefaults.data(forKey: transactionsKey),
           let decoded = try? JSONDecoder().decode([Transaction].self, from: data) {
            transactions = decoded
        }
    }
    
    var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "ARS"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: balance)) ?? "$\(balance)"
    }
    
    var formattedIncome: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "ARS"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: monthlyIncome)) ?? "$\(monthlyIncome)"
    }
    
    var formattedExpenses: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "ARS"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: monthlyExpenses)) ?? "$\(monthlyExpenses)"
    }
    
    var formattedSavings: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "ARS"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: monthlySavings)) ?? "$\(monthlySavings)"
    }
    
    private func addSampleData() {
        let sampleTransactions = [
            Transaction(title: "Salario", amount: 800000, category: .other, type: .variable, isIncome: true, description: "Salario mensual"),
            Transaction(title: "Supermercado", amount: 150000, category: .supermarket, type: .variable, description: "Compra semanal"),
            Transaction(title: "Restaurante", amount: 45000, category: .restaurant, type: .variable, description: "Cena con amigos"),
            Transaction(title: "Transporte", amount: 25000, category: .transport, type: .fixed, description: "Subte y colectivo"),
            Transaction(title: "Ahorro", amount: 100000, category: .other, type: .saving, description: "Ahorro mensual"),
            Transaction(title: "Ropa", amount: 75000, category: .clothing, type: .variable, description: "Compra de ropa")
        ]
        
        for transaction in sampleTransactions {
            transactions.append(transaction)
        }
        
        saveTransactions()
    }
}