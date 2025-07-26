//
//  HomeView.swift
//  Gasti
//
//  Created by Constanza Lancieri on 10/05/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: ExpenseViewModel
    @State private var selectedTab = 0
    @State private var showAddExpense = false

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                        HomeDashboardView(viewModel: viewModel)
                            .tabItem {
                                Image(systemName: "house.fill")
                            }.tag(0)

                        TransactionListView(viewModel: viewModel)
                            .tabItem {
                                Image(systemName: "list.bullet")
                            }.tag(1)

                        Text("Perfil")
                            .font(.title)
                            .foregroundColor(.secondary)
                            .tabItem {
                                Image(systemName: "person")
                            }.tag(2)
                }
                .accentColor(Color(red: 0.3, green: 0.2, blue: 0.6))

                // Botón flotante solo en la pestaña de Inicio
                if selectedTab == 0 {
                    FloatingAddButton(showAddExpense: $showAddExpense)
                }
            }
            .navigationDestination(isPresented: $showAddExpense) {
                AddExpenseView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: ExpenseViewModel())
}