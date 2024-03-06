//
//  Transaction.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 06.03.2024.
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
    let category: Category?
    let date: Date
    let description: String?
}
