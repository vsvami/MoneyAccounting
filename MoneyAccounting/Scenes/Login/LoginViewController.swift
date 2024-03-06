//
//  LoginViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet var passwordView: UIView!
    @IBOutlet var loginView: UIView!
    
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewDidLayoutSubviews() {
        loginView.layer.cornerRadius = loginView.frame.height / 2
        passwordView.layer.cornerRadius = passwordView.frame.height / 2
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }
}
