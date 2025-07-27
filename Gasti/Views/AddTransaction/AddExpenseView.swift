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
    @State private var description = ""
    @State private var showDatePicker = false
    @State private var showCategories = false
    
    private var formattedAmount: String {
        if amount.isEmpty {
            return "0"
        }
        return amount
    }
    
    private var selectedCategoryEmoji: String {
        switch transactionType {
        case .expense:
            return selectedExpenseCategory?.emoji ?? "📁"
        case .saving:
            return selectedSavingCategory?.emoji ?? "💰"
        case .income:
            return selectedIncomeCategory?.emoji ?? "💵"
        }
    }
    
    private var selectedCategoryName: String {
        switch transactionType {
        case .expense:
            return selectedExpenseCategory?.rawValue ?? "Categoría"
        case .saving:
            return selectedSavingCategory?.rawValue ?? "Categoría"
        case .income:
            return selectedIncomeCategory?.rawValue ?? "Categoría"
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Menu {
                        ForEach(TransactionType.allCases) { type in
                            Button(action: { 
                                transactionType = type
                                selectedExpenseCategory = nil
                                selectedSavingCategory = nil
                                selectedIncomeCategory = nil
                            }) {
                                Text(type.rawValue)
                            }
                        }
                    } label: {
                        HStack {
                            Text(transactionType.rawValue)
                                .foregroundColor(transactionType == .expense ? Color.red : (transactionType == .saving ? Color.green : Color.blue))
                            Image(systemName: "chevron.down")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 30)

                // Amount Display
                VStack(spacing: 8) {
                    HStack(alignment: .center, spacing: 0) {
                        Text("$")
                            .font(.system(size: 40, weight: .medium))
                            .foregroundColor(.white)
                        Text(formattedAmount)
                            .font(.system(size: 60, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 40)

//                    TextField("Agrega una descripción", text: $description)
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(.gray)
                }
                
                Spacer()

                // Bottom Section (Category, Date, Type)
                VStack(spacing: 20) {
                    // Category and Date Selection
                    HStack(spacing: 12) {
                        Button(action: { withAnimation { showCategories.toggle() } }) {
                            HStack {
                                Text(selectedCategoryEmoji)
                                Text(selectedCategoryName)
                                    .foregroundColor(.white)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(showCategories ? 180 : 0))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .cornerRadius(20)
                        }
                        
                        Button(action: { showDatePicker = true }) {
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.white)
                                Text(selectedDate, style: .date)
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .cornerRadius(20)
                        }
                    }
                    
                    if showCategories {
                        CategoryCarouselView(
                            transactionType: transactionType,
                            selectedExpenseCategory: $selectedExpenseCategory,
                            selectedSavingCategory: $selectedSavingCategory,
                            selectedIncomeCategory: $selectedIncomeCategory
                        )
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    // Expense Type Selector (only for expenses)
                    if transactionType == .expense {
                        VStack(spacing: 8) {
                            HStack(spacing: 15) {
                                Text("Tipo de gasto")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 16, weight: .semibold))
                                
                                Button(action: { selectedType = .fixed }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "lock.fill")
                                            .font(.system(size: 14))
                                        Text("Fijo")
                                            .font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedType == .fixed ? Color(red: 0, green: 0.3, blue: 0.6).opacity(0.3) : Color(red: 0.15, green: 0.15, blue: 0.15))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(selectedType == .fixed ? Color.blue : Color.clear, lineWidth: 2)
                                    )
                                }
                                
                                Button(action: { selectedType = .variable }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "chart.bar.fill")
                                            .font(.system(size: 14))
                                        Text("Variable")
                                            .font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedType == .variable ? Color(red: 0.6, green: 0.3, blue: 0).opacity(0.3) : Color(red: 0.15, green: 0.15, blue: 0.15))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(selectedType == .variable ? Color.orange : Color.clear, lineWidth: 2)
                                    )
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 8)

                // Custom Numpad
                CustomNumPad(amount: $amount)
                    .frame(height: 225)
                    .padding(.bottom, 10)

                // Add Transaction Button
                Button(action: saveTransaction) {
                    Text("Agregar transacción")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(amount.isEmpty ? Color(red: 0.15, green: 0.15, blue: 0.15) : Color(red: 0.3, green: 0.2, blue: 0.6))
                        )
                }
                .disabled(amount.isEmpty)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showDatePicker) {
            DatePickerSheet(selectedDate: $selectedDate)
        }
    }
    
    private func saveTransaction() {
        guard let amountValue = Double(amount.replacingOccurrences(of: ",", with: ".")) else { return }
        
        let transaction: Transaction
        
        switch transactionType {
        case .expense:
            guard let category = selectedExpenseCategory else { return }
            transaction = Transaction(
                title: category.rawValue,
                amount: amountValue,
                category: category,
                type: selectedType,
                isIncome: false,
                description: description.isEmpty ? nil : description
            )
        case .income:
            guard let category = selectedIncomeCategory else { return }
            transaction = Transaction(
                title: category.rawValue,
                amount: amountValue,
                category: .other,
                type: .variable,
                isIncome: true,
                description: description.isEmpty ? nil : description
            )
        case .saving:
            guard let category = selectedSavingCategory else { return }
            transaction = Transaction(
                title: category.rawValue,
                amount: amountValue,
                category: .other,
                type: .saving,
                isIncome: false,
                description: description.isEmpty ? nil : description
            )
        }
        
        viewModel.addTransaction(transaction)
        presentationMode.wrappedValue.dismiss()
    }
}

struct CategoryCarouselView: View {
    let transactionType: TransactionType
    @Binding var selectedExpenseCategory: ExpenseCategory?
    @Binding var selectedSavingCategory: SavingCategory?
    @Binding var selectedIncomeCategory: IncomeCategory?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                switch transactionType {
                case .expense:
                    ForEach(ExpenseCategory.allCases) { category in
                        CategoryButton(
                            emoji: category.emoji,
                            title: category.rawValue,
                            isSelected: selectedExpenseCategory == category,
                            action: { selectedExpenseCategory = category }
                        )
                    }
                case .saving:
                    ForEach(SavingCategory.allCases) { category in
                        CategoryButton(
                            emoji: category.emoji,
                            title: category.rawValue,
                            isSelected: selectedSavingCategory == category,
                            action: { selectedSavingCategory = category }
                        )
                    }
                case .income:
                    ForEach(IncomeCategory.allCases) { category in
                        CategoryButton(
                            emoji: category.emoji,
                            title: category.rawValue,
                            isSelected: selectedIncomeCategory == category,
                            action: { selectedIncomeCategory = category }
                        )
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct CategoryButton: View {
    let emoji: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(emoji)
                    .font(.system(size: 20))
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(isSelected ? Color(red: 0.3, green: 0.2, blue: 0.6) : Color(red: 0.15, green: 0.15, blue: 0.15))
            .cornerRadius(20)
        }
    }
}

#Preview {
    AddExpenseView(viewModel: ExpenseViewModel())
}
