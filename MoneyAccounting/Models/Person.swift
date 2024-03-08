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
    
    static func getPerson() -> Person {
        let dataStore = DataStore.shared
        
        let randomCurrency = Int.random(in: 0 ..< dataStore.currency.count)
        let randomAmount = Double(Int.random(in: 10 ... 2000))
        let randomCategory = Int.random(in: 0 ..< dataStore.categories.count)
        
        let date1 = Date.parse("2018-01-01")
        let date2 = Date.parse("2019-01-01")
        let randomDate = Date.randomBetween(start: date1, end: date2)
        
        var transactions: [Transaction] = []
        
        for iteration in 0...20 {
            transactions.append(
                Transaction(
                    type: .expense,
                    currency: dataStore.currency[randomCurrency],
                    amount: randomAmount,
                    category: dataStore.categories[randomCategory],
                    date: randomDate,
                    description: "Something"
            ))
        }
        
        return Person(
            firstName: "Tommy",
            lastName: "Shelby",
            profileImage: nil,
            financialPortfolio: FinancialPortfolio(transactions: transactions)
        )
    }
}

extension Date {
    
    static func randomBetween(start: String, end: String, format: String = "yyyy-MM-dd") -> String {
        let date1 = Date.parse(start, format: format)
        let date2 = Date.parse(end, format: format)
        return Date.randomBetween(start: date1, end: date2).dateString(format)
    }

    static func randomBetween(start: Date, end: Date) -> Date {
        var date1 = start
        var date2 = end
        if date2 < date1 {
            let temp = date1
            date1 = date2
            date2 = temp
        }
        let span = TimeInterval.random(in: date1.timeIntervalSinceNow...date2.timeIntervalSinceNow)
        return Date(timeIntervalSinceNow: span)
    }

    func dateString(_ format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }
}
