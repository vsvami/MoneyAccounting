//
//  TransactionsStore.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 08.03.2024.
//

import Foundation

final class TransactionStore {
    let categoriesStore = CategoriesStore.shared
    
    static let shared = TransactionStore()
    
    // Список всех транзакций
    private var transactions: [Transaction] = [
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 1200,
            category: CategoriesStore.shared.categories[0],
            date: Date(timeIntervalSinceReferenceDate: 500000000),
            description: "Something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 348,
            category: CategoriesStore.shared.categories[1],
            date: Date(timeIntervalSinceReferenceDate: 50000000),
            description: "Something yet"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 540,
            category: CategoriesStore.shared.categories[2],
            date: Date(timeIntervalSinceReferenceDate: 500000000),
            description: "Do something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 820,
            category: CategoriesStore.shared.categories[1],
            date: Date(timeIntervalSinceReferenceDate: 50000000),
            description: "Buy something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[1],
            amount: 235,
            category: CategoriesStore.shared.categories[3],
            date: Date(timeIntervalSinceReferenceDate: 470000000),
            description: "Put something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 140,
            category: CategoriesStore.shared.categories[0],
            date: Date(timeIntervalSinceReferenceDate: 470000000),
            description: "Sell something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 740,
            category: CategoriesStore.shared.categories[3],
            date: Date(timeIntervalSinceReferenceDate: 470000000),
            description: "Fly something"
        )
    ]
    
    // Получить список всех транзакций
    func getAllTransactions() -> [Transaction] {
        transactions
    }
    
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
