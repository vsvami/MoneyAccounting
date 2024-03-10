//
//  RegistrationViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    @IBOutlet var loginTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        view.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
    }
    
    @IBAction func backAction() {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAction() {
        guard let email = emailTF.text, !email.isEmpty,
              let password = passwordTF.text, !password.isEmpty,
              let login = loginTF.text, !login.isEmpty else {
            //TODO:
            //прописать алерт неверный логин и пароль
            return
        }
        
        let newUser = User(email: email, password: password, person: Person.getPerson())
        
        // Добавление нового пользователя в UsersStore
        UsersStore.shared.addUser(newUser)
        
        self.dismiss(animated: true)
    }
    
    private func setTextFields() {
        loginTF.setCornerRadius()
        passwordTF.setCornerRadius()
        emailTF.setCornerRadius()
        
        loginTF.setBorderStyle()
        passwordTF.setBorderStyle()
        emailTF.setBorderStyle()
        
        loginTF.setLeftPaddingPoints(20)
        loginTF.setRightPaddingPoints(20)
    }
}
