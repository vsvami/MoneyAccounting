//
//  Transaction.swift
//  MoneyAccounting
//

import Foundation

enum TransactionType {
    case income
    case expense
}

//Модель для добавления расходов/доходов
struct Transaction {
    let type: TransactionType
    let currency: Character
    let amount: Double
    let category: Category
    let date: Date
    let description: String?
}
