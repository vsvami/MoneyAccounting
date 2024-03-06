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
            colorImage: UIImage(named: "gradient1") ?? .backgroundMain),
        Category(
            name: "Одежда",
            icon: "tshirt.fill",
            colorImage: UIImage(named: "gradient2") ?? .backgroundMain),
        Category(
            name: "Питомцы",
            icon: "pawprint.fill",
            colorImage: UIImage(named: "gradient3") ?? .backgroundMain),
        Category(
            name: "Продукты",
            icon: "cart.fill",
            colorImage: UIImage(named: "gradient4") ?? .backgroundMain),
        Category(
            name: "Путешествия",
            icon: "airplane",
            colorImage: UIImage(named: "gradient5") ?? .backgroundMain),
        Category(
            name: "Развлечения",
            icon: "gamecontroller.fill",
            colorImage: UIImage(named: "gradient6") ?? .backgroundMain),
        Category(
            name: "Рестораны и кафе",
            icon: "fork.knife",
            colorImage: UIImage(named: "gradient7") ?? .backgroundMain),
        Category(
            name: "Транспорт",
            icon: "car.fill",
            colorImage: UIImage(named: "gradient8") ?? .backgroundMain),
        Category(
            name: "Фитнес",
            icon: "figure.cooldown",
            colorImage: UIImage(named: "gradient9") ?? .backgroundMain),
        Category(
            name: "Другое",
            icon: "ellipsis.circle.fill",
            colorImage: UIImage(named: "gradient10") ?? .backgroundMain),
    ]
    
    let currency: [Character] = ["₽", "€", "$"]
    
    private init() {}
}
