//
//  AddExpenseView.swift
//  Gasti
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ExpenseViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var amount = ""
    @State private var selectedExpenseCategory: ExpenseCategory? = nil
    @State private var selectedSavingCategory: SavingCategory? = nil
    @State private var selectedIncomeCategory: IncomeCategory? = nil
    @State private var selectedType: ExpenseType = .variable
    @State private var transactionType: TransactionType = .expense
    @State private var selectedDate = Date()
    @State private var isRepeating = false
    @State private var isCategoryExpanded = false
    @State private var description = ""
    @State private var showDatePicker = false
    @State private var isDescriptionFocused = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                   // ExpenseTypeSelector(selectedType: $transactionType)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 8)
                
                Spacer()
                
                // Monto y descripción
//                (
//                    amount: $amount,
//                    description: $description
//                )
                
                Spacer()
                
                VStack(spacing: 0) {
                    // Selector de categoría y fecha
                    HStack(spacing: 12) {
                        ExpandedCategoryList(
                            transactionType: $transactionType,
                            selectedExpenseCategory: $selectedExpenseCategory,
                            selectedSavingCategory: $selectedSavingCategory,
                            selectedIncomeCategory: $selectedIncomeCategory,
                            isCategoryExpanded: $isCategoryExpanded
                        )
                        
                        // Fecha
                        Button(action: { showDatePicker = true }) {
                            HStack(spacing: 6) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.secondary)
                                Text(selectedDate, style: .date)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.primary)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 4)
                    
                    if isCategoryExpanded {
                        ExpandedCategoryList(
                            transactionType: $transactionType,
                            selectedExpenseCategory: $selectedExpenseCategory,
                            selectedSavingCategory: $selectedSavingCategory,
                            selectedIncomeCategory: $selectedIncomeCategory,
                            isCategoryExpanded: $isCategoryExpanded
                        )
                    }
                }
                
                // Selector de tipo de gasto
                if transactionType == .expense {
                    ExpenseTypeSelector(selectedType: $selectedType)
                        .padding(.horizontal, 20)
                }
                
                // Teclado custom y botón
                VStack(spacing: 10) {
                    if !isDescriptionFocused {
                        CustomNumPad(amount: $amount)
                    }
                    Button(action: saveTransaction) {
                        Text("Agregar transacción")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(amount.isEmpty ? Color.gray : Color(red: 0.3, green: 0.2, blue: 0.6))
                            )
                            .shadow(color: amount.isEmpty ? Color.clear : Color(red: 0.3, green: 0.2, blue: 0.6).opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .disabled(amount.isEmpty)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 16)
                }
                .padding(.top, 10)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showDatePicker) {
                DatePickerSheet(selectedDate: $selectedDate)
            }
        }
    }
    
    private func saveTransaction() {
        guard let amountValue = Double(amount.replacingOccurrences(of: ",", with: ".")) else { return }
        
        let transaction: Transaction
        
        switch transactionType {
        case .expense:
            transaction = Transaction(
                title: selectedExpenseCategory?.rawValue ?? "",
                amount: amountValue,
                category: selectedExpenseCategory ?? .other,
                type: selectedType,
                isIncome: false,
                description: description.isEmpty ? nil : description
            )
        case .income:
            transaction = Transaction(
                title: selectedIncomeCategory?.rawValue ?? "",
                amount: amountValue,
                category: .other, // No category for income
                type: .variable, // No type for income
                isIncome: true,
                description: description.isEmpty ? nil : description
            )
        case .saving:
            transaction = Transaction(
                title: selectedSavingCategory?.rawValue ?? "",
                amount: amountValue,
                category: .other, // No category for saving
                type: .saving,
                isIncome: false,
                description: description.isEmpty ? nil : description
            )
        }
        
        viewModel.addTransaction(transaction)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddExpenseView(viewModel: ExpenseViewModel())
}
