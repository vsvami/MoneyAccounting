//
//  AddIncomeViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 06/03/2024.
//

import UIKit

final class AddIncomeViewController: UIViewController {

    @IBOutlet var amountTF: UITextField!
    @IBOutlet var chooseDateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField(amountTF, withText: "Введите сумму")
        setButton(chooseDateButton)
    }
    
    @IBAction func chooseDateButtonAction() {
    }
}

// MARK: - Private Methods
extension AddIncomeViewController {
    private func setTextField(_ textField: UITextField, withText placeholder: String) {
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        textField.setBorderStyle()
        textField.setCornerRadius()
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(
                red: 134/255,
                green: 143/255,
                blue: 165/255,
                alpha: 1
            )]
        )
    }
    
    private func setButton(_ button: UIButton) {
        button.backgroundColor = UIColor(
            red: 249/255,
            green: 249/255,
            blue: 252/255,
            alpha: 1
        )
        button.layer.cornerRadius = button.frame.height / 2
        button.setTitleColor(
            UIColor(
                red: 134/255,
                green: 143/255,
                blue: 165/255,
                alpha: 1
            ),
            for: .normal
        )
    }
}
