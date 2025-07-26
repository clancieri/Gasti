
//
//  TransactionListView.swift
//  Gasti
//
//  Created by Constanza Lancieri on 10/05/2025.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.transactions.isEmpty {
                    VStack {
                        Text("No hay transacciones")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Text("Agrega tu primer gasto o ingreso")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    List {
                        ForEach(viewModel.transactions.sorted(by: { $0.date > $1.date })) { transaction in
                            TransactionRowView(transaction: transaction)
                        }
                        .onDelete(perform: deleteTransaction)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Transacciones")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func deleteTransaction(at offsets: IndexSet) {
        let transactionsToDelete = offsets.map { viewModel.transactions.sorted(by: { $0.date > $1.date })[$0] }
        for transaction in transactionsToDelete {
            viewModel.deleteTransaction(transaction)
        }
    }
}

struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 16) {
            // Category Icon
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(transaction.category.color.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Text(transaction.category.emoji)
                    .font(.title2)
            }
            
            // Transaction Details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(transaction.formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Amount and Payment Method
            VStack(alignment: .trailing, spacing: 4) {
                Text(transaction.formattedAmount)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(transaction.isIncome ? Color(red: 0.4, green: 0.8, blue: 0.6) : Color(red: 0.9, green: 0.4, blue: 0.4))
                
                Text(transaction.isIncome ? "Ingreso" : "Gasto")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TransactionListView(viewModel: ExpenseViewModel())
}
