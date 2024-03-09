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
            date: Date.parse("2024-03-09"),
            description: "Something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 348,
            category: CategoriesStore.shared.categories[1],
            date: Date.parse("2024-03-09"),
            description: "Something yet"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 540,
            category: CategoriesStore.shared.categories[2],
            date: Date.parse("2024-03-09"),
            description: "Do something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 820,
            category: CategoriesStore.shared.categories[1],
            date: Date.parse("2024-03-09"),
            description: "Buy something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[1],
            amount: 235,
            category: CategoriesStore.shared.categories[3],
            date: Date.parse("2024-03-08"),
            description: "Put something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 140,
            category: CategoriesStore.shared.categories[0],
            date: Date.parse("2024-03-08"),
            description: "Sell something"
        ),
        Transaction(
            type: .expense,
            currency: CategoriesStore.shared.currency[0],
            amount: 740,
            category: CategoriesStore.shared.categories[3],
            date: Date.parse("2024-03-07"),
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

// MARK: - Date parse
extension Date {
    
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> String {
        let date1 = Date.parse(start, format: format)
        let date2 = Date.parse(end, format: format)
        return Date.randomBetween(start: date1, end: date2).dateString(format)
    }
    
    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }
    
    func dateString(_ format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
        return date
    }
}
