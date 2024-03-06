//
//  FinancialPortfolio.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 06.03.2024.
//

import Foundation

struct FinancialPortfolio {
    let transactions: [Transaction]
    
    var totalBalance: Double {
        transactions.reduce(0) { balance, transaction in
            switch transaction.type {
            case .income:
                return balance + transaction.amount
            case .expense:
                return balance - transaction.amount
            }
        }
    }
}
