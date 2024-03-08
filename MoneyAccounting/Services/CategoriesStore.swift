//
//  DataStore.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 06.03.2024.
//

import UIKit

final class CategoriesStore {
    static let shared = CategoriesStore()
    
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

