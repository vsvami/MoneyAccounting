//
//  AddExpenseViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 06/03/2024.
//

import UIKit

final class AddExpenseViewController: UIViewController {

    @IBOutlet var nameExpenceTextField: UITextField!
    @IBOutlet var addAmountTextField: UITextField!
    
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var chooseCategoryButton: UIButton!
    
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField(nameExpenceTextField, withText: "Название расхода")
        setTextField(addAmountTextField, withText: "Введите сумму")
        
        dateButton.setOrdinaryButton()
        chooseCategoryButton.setOrdinaryButton()
        
        addButton.setAccentButton()
    }
    
    private func setTextField(_ textField: UITextField, withText placeholder: String) {
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        textField.setBorderStyle()
        textField.setCornerRadius()
        textField.backgroundColor = UIColor(
            red: 249/255,
            green: 249/255,
            blue: 252/255,
            alpha: 1
        )
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
    
}
