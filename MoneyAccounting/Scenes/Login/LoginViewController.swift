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
    }
}
