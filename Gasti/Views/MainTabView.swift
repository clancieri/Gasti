//
//  MainTabView.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = ExpenseViewModel()
    
    var body: some View {
        ZStack {
            TabView {
                // Home Tab
                HomeView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Inicio")
                    }
                
                // Transactions Tab
                NavigationView {
                    TransactionListView(viewModel: viewModel)
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Movimientos")
                }
                
                // Profile Tab (placeholder)
                Color.clear
                    .tabItem {
                        Image(systemName: "person")
                        Text("Perfil")
                    }
            }
            .accentColor(Color(red: 0.3, green: 0.2, blue: 0.6))
            
            // Floating Action Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: AddExpenseView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
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
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 100) // Adjust based on tab bar height
                }
            }
        }
    }
}

#Preview {
    MainTabView()
} 