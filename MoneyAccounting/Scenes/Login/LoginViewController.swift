//
//  LoginViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet var logInTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    // MARK: - Private Properties
    private let user = User.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        
        logInTextField.setCornerRadius()
        passwordTextField.setCornerRadius()
        
        logInTextField.setBorderStyle()
        passwordTextField.setBorderStyle()
        
        logInTextField.setLeftPaddingPoints(20)
        logInTextField.setRightPaddingPoints(20)
        
        passwordTextField.setLeftPaddingPoints(20)
        passwordTextField.setRightPaddingPoints(20)
        
        let backgroundImage = UIImageView(image: UIImage(named: "backgroundLogin"))
        backgroundImage.frame = view.bounds
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        //
//        logInTextField.text = "Timcook666"
//        passwordTextField.text = "param-pam-pam"
        logInTextField.text = "developers@icloid.com"
        passwordTextField.text = "param-pam-pam"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard logInTextField.text == user.email, passwordTextField.text == user.password else {
            showAlert(
                withTitle: "Invalid login or password",
                andMessage: "Please, enter correct login and password") {
                    self.passwordTextField.text = ""
                }
            return false
        }
        return true
    }
    
    @IBAction func forgotRegisterData(_ sender: UIButton) {
        sender.tag == 0
        ? showAlert(withTitle: "Oops!", andMessage: "Your name is \(user.email)")
        : showAlert(withTitle: "Oops!", andMessage: "Your password is \(user.password)")
    }
    
    // MARK: - Private Methods
    private func showAlert(
        withTitle title: String,
        andMessage message: String,
        complition: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            complition?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

