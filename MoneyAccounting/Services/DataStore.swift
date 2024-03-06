//
//  DataStore.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 06.03.2024.
//

import Foundation

final class DataStore {
    static let shared = DataStore()
    
    let categories = [
        Category(name: "Здоровье", icon: "cross.case.fill"),
        Category(name: "Интернет", icon: "wifi"),
        Category(name: "Коммунальные услуги", icon: "lightbulb.fill"),
        Category(name: "Мобильная связь", icon: "iphone.gen1"),
        Category(name: "Образование", icon: "book.fill"),
        Category(name: "Одежда", icon: "tshirt.fill"),
        Category(name: "Питомцы", icon: "pawprint.fill"),
        Category(name: "Подарки", icon: "gift.fill"),
        Category(name: "Подписки и сервисы ", icon: "music.note.list"),
        Category(name: "Продукты", icon: "cart.fill"),
        Category(name: "Путешествия", icon: "airplane"),
        Category(name: "Развлечения", icon: "gamecontroller.fill"),
        Category(name: "Рестораны и кафе", icon: "fork.knife"),
        Category(name: "Сбережения и инвестиции", icon: "banknote.fill"),
        Category(name: "Транспорт", icon: "car.fill"),
        Category(name: "Фитнес", icon: "figure.cooldown"),
        Category(name: "Другое", icon: "ellipsis.circle.fill"),
    ]
    
    let currency: [Character] = ["₽", "€", "$"]
    
    private init() {}
}
