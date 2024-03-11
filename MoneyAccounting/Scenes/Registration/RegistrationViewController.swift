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
            showAlertForEmptyFields()
            return
        }
        
        //let newUser = User(email: email, password: password, person: Person.getPerson())
        // Добавление нового пользователя в UsersStore
        //UsersStore.shared.addUser(newUser)
        
        //TODO: не отрабатывает закрытие?
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
    
    private func showAlertForEmptyFields() {
        let alert = UIAlertController(
            title: "Незаполненные поля", // Заголовок
            message: "Пожалуйста, заполните все поля.", // Сообщение
            preferredStyle: .alert // Стиль
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
