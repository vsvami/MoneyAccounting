//
//  Person.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 06.03.2024.
//

import Foundation

struct Person {
    let firstName: String
    let lastName: String
    let profileImage: Data?
    var financialPortfolio: FinancialPortfolio?
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
