//
//  ExpandedCategoryList.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import SwiftUI

struct ExpandedCategoryList: View {
    @Binding var transactionType: TransactionType
    @Binding var selectedExpenseCategory: ExpenseCategory?
    @Binding var selectedSavingCategory: SavingCategory?
    @Binding var selectedIncomeCategory: IncomeCategory?
    @Binding var isCategoryExpanded: Bool
    
    var body: some View {
        VStack {
            if transactionType == .expense {
                ForEach(ExpenseCategory.allCases) { category in
                    Button(action: {
                        selectedExpenseCategory = category
                        isCategoryExpanded = false
                    }) {
                        HStack {
                            Text(category.rawValue)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedExpenseCategory == category {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            } else if transactionType == .income {
                ForEach(IncomeCategory.allCases) { category in
                    Button(action: {
                        selectedIncomeCategory = category
                        isCategoryExpanded = false
                    }) {
                        HStack {
                            Text(category.rawValue)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedIncomeCategory == category {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            } else {
                ForEach(SavingCategory.allCases) { category in
                    Button(action: {
                        selectedSavingCategory = category
                        isCategoryExpanded = false
                    }) {
                        HStack {
                            Text(category.rawValue)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedSavingCategory == category {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}