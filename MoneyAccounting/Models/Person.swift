//
//  Person.swift
//  MoneyAccounting
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
