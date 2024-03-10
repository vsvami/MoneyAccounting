//
//  UsersStore.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 10.03.2024.
//

import Foundation

final class UsersStore {
    static let shared = UsersStore()
    
    var users = User(
        email: "developers@icloid.com",
        password: "param-pam-pam",
        person: Person.getPerson()
    )
    
    private init() {}
}

