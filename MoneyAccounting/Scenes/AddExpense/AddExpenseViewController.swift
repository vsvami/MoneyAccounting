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
    
    @IBAction func addAction() {
        dismiss(animated: true)
    }
    
    private func setTextField(_ textField: UITextField, withText placeholder: String) {
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        textField.setBorderStyle()
        textField.setCornerRadius()
        
        textField.backgroundColor = .customLightGray
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(
                named: "customDarkGray"
            ) ?? .customDarkGray]
        )
    }
    
}
