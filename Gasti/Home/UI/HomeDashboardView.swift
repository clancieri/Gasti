
//
//  HomeDashboardView.swift
//  Gasti
//
//  Created by Constanza Lancieri on 10/05/2025.
//

import SwiftUI

struct HomeDashboardView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    @State private var selectedDate = Date()

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                // Month Selector
                MonthPickerView()
                    .padding(.bottom, 10)

                // Available Balance Card´
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Balance disponible")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))

                            Text(viewModel.formattedBalance)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                        }

                        Spacer()

                        // Decorative graphics
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.4, green: 0.8, blue: 0.6).opacity(0.3))
                                .frame(width: 60, height: 60)
                                .offset(x: 20, y: -10)

                            Circle()
                                .fill(Color(red: 0.9, green: 0.4, blue: 0.4).opacity(0.3))
                                .frame(width: 40, height: 40)
                                .offset(x: -10, y: 10)

                            Circle()
                                .fill(Color(red: 0.6, green: 0.4, blue: 0.8).opacity(0.3))
                                .frame(width: 30, height: 30)
                                .offset(x: 30, y: 20)
                        }
                    }

                    Button("Ver detalles") {
                        // Action for details
                    }
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                }
                .padding(24)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.3, green: 0.2, blue: 0.6),
                            Color(red: 0.4, green: 0.3, blue: 0.7)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(20)
                
                // Savings Card
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ahorro")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text("Total ahorrado")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        Text(viewModel.formattedSavings)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(24)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.6, green: 0.4, blue: 0.8),
                            Color(red: 0.7, green: 0.5, blue: 0.9)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(20)
                .padding(.bottom, 15)

                // Cash Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Resumen")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 16) {
                        // Income Card
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.4, green: 0.8, blue: 0.6).opacity(0.2))
                                    .frame(width: 50, height: 50)
                                
                                Text("💰")
                                    .font(.title2)
                            }
                            
                            Text(viewModel.formattedIncome)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Text("Ingresos")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .background(Color(red: 0.4, green: 0.8, blue: 0.6).opacity(0.1))
                        .cornerRadius(16)
                        
                        // Expense Card
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.9, green: 0.4, blue: 0.4).opacity(0.2))
                                    .frame(width: 50, height: 50)
                                
                                Text("💸")
                                    .font(.title2)
                            }
                            
                            Text(viewModel.formattedExpenses)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            Text("Gastos")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .background(Color(red: 0.9, green: 0.4, blue: 0.4).opacity(0.1))
                        .cornerRadius(16)
                    }
                }
                .padding(.bottom, 20)

                // Recent Transactions Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Movimientos")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        NavigationLink(destination: TransactionListView(viewModel: viewModel)) {
                            Text("Ver todos")
                                .font(.caption)
                                .foregroundColor(Color(red: 0.3, green: 0.2, blue: 0.6))
                        }
                    }
                    
                    if viewModel.transactions.isEmpty {
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "list.bullet.circle")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                            }
                            
                            Text("No hay movimientos")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text("Agrega tu primer gasto o ingreso")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(Array(viewModel.transactions.sorted(by: { $0.date > $1.date }).prefix(5))) { transaction in
                                ModernTransactionRowView(transaction: transaction)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Gastos")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ModernTransactionRowView: View {
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
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
