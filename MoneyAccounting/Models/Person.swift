//
//  Person.swift
//  MoneyAccounting
//

import Foundation

struct Person {
    
    var firstName: String
    var lastName: String
    var profileImage: Data?
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
