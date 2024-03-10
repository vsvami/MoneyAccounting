//
//  UsersStore.swift
//  MoneyAccounting
//
//  Created by Дарья Кобелева on 10.03.2024.
//

import Foundation

final class UsersStore {
    static let shared = UsersStore()
    //var currentUser: User
    private var users: [User] = [
        User(
            email: "developers@icloid.com",
            password: "param-pam-pam",
            person: Person.getPerson()
        ),
        User(email: "zero@icloud.com",
             password: "1111",
             person: Person.getPerson())
    ]
    
    func addUser(_ user: User) {
        users.append(user)
    }
    
    private init() {}
}


//func getUser(with email: String, and password: String) -> User? {
//    for user in users {
//        if user.email == email {
//            if user.password == password {
//                return user
//            } else {
//                return nil
//            }
//        }
//    }
//    return nil
//}
