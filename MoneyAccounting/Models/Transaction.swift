//
//  Transaction.swift
//  MoneyAccounting
//

import Foundation

enum TransactionType {
    case income
    case expense
}

//Модель для добавления расходов/доходов(можно разделить на доход и расход)
struct Transaction {
    var type: TransactionType
    var currency: Character
    var amount: Double
    var category: Category
    var date: Date
    var description: String?
}
