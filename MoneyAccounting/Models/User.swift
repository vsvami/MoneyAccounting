//
//  User.swift
//  MoneyAccounting
//

struct User {
    let email: String
    let password: String
   // let login: String
    var person: Person? // Ссылка на личные данные пользователя
    
    static func getUser() -> User {
        User(
            email: "developers@icloid.com",
            password: "param-pam-pam",
            person: Person.getPerson()
        )
    }
}
