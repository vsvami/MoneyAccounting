//
//  PersonStore.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 10.03.2024.
//

import Foundation

final class PersonsStore {
    static let shared = PersonsStore()
    
    var person = Person(
        firstName: "Tim",
        lastName: "Cook",
        profileImage: nil,
        financialPortfolio: TransactionStore.shared
    )
    
    private init() {}
}

