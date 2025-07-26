//
//  TransactionType.swift
//  Gasti
//
//  Created by Constanza Lancieri on 11/05/2025.
//

import Foundation

enum TransactionType: String, CaseIterable, Identifiable {
    case expense = "Gasto"
    case income = "Ingreso"
    case saving = "Ahorro"
    
    var id: String { self.rawValue }
}