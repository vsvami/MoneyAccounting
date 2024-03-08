//
//  DataStore.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 06.03.2024.
//

import UIKit

final class DataStore {
    static let shared = DataStore()
    
    let categories = [
        Category(
            name: "Здоровье",
            icon: "cross.case.fill",
            colorImage: "gradient1"),
        Category(
            name: "Одежда",
            icon: "tshirt.fill",
            colorImage: "gradient2"),
        Category(
            name: "Питомцы",
            icon: "pawprint.fill",
            colorImage: "gradient3"),
        Category(
            name: "Продукты",
            icon: "cart.fill",
            colorImage: "gradient4"),
        Category(
            name: "Путешествия",
            icon: "airplane",
            colorImage: "gradient5"),
        Category(
            name: "Развлечения",
            icon: "gamecontroller.fill",
            colorImage: "gradient6"),
        Category(
            name: "Рестораны и кафе",
            icon: "fork.knife",
            colorImage: "gradient7"),
        Category(
            name: "Транспорт",
            icon: "car.fill",
            colorImage: "gradient8"),
        Category(
            name: "Фитнес",
            icon: "figure.cooldown",
            colorImage: "gradient9"),
        Category(
            name: "Другое",
            icon: "ellipsis.circle.fill",
            colorImage: "gradient10"),
    ]
    
    let currency: [Character] = ["₽", "€", "$"]
    
    private init() {}
}

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
    
    // Метод для получения суммы всех транзакций по каждой категории категории
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
