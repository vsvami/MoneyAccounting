//
//  Person.swift
//  MoneyAccounting
//

import Foundation

struct Person {
    
    let firstName: String
    let lastName: String
    let profileImage: Data?
    let financialPortfolio: TransactionStore
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    static func getPerson() -> Person {
        
        Person(
            firstName: "Tim",
            lastName: "Cook",
            profileImage: nil,
            financialPortfolio: TransactionStore.shared
        )
        
    }
}
