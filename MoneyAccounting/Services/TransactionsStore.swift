//
//  TransactionsStore.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 08.03.2024.
//

import Foundation

final class TransactionStore {
    static let shared = TransactionStore()
    
    // Список всех транзакций
    private var transactions: [Transaction] = []
    
    // Добавление транзакции
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    // Получение всех транзакций по категории
    func transactions(for categoryName: String, from allTransactions: [Transaction]) -> [Transaction] {
        allTransactions.filter { $0.category.name == categoryName }
    }
    
    // Метод для получения суммы всех транзакций по каждой категории
    func totalAmount(for category: Category, transactions: [Transaction]) -> Double {
        return transactions.filter { $0.category.name == category.name }
                           .reduce(0) { $0 + $1.amount }
    }
    
    // Метод для получения баланса (сумма доходов минус сумма расходов)
    func totalBalance() -> Double {
        let incomeTotal = transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
        let expenseTotal = transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
        return incomeTotal - expenseTotal
    }
    private init() {}
}
