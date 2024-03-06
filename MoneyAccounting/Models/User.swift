//
//  User.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 06.03.2024.
//

import Foundation

struct User {
    let email: String
    let password: String
    var person: Person? // Ссылка на личные данные пользователя
}
