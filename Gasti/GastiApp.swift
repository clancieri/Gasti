//
//  GastiApp.swift
//  Gasti
//
//  Created by Constanza Lancieri on 10/05/2025.
//

import SwiftUI

@main
struct GastiApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: ExpenseViewModel())
        }
    }
}
