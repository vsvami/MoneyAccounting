//
//  AddExpenseViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 06/03/2024.
//

import UIKit

final class AddExpenseViewController: UIViewController {

    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var nameExpenceTextField: UITextField!
    @IBOutlet var chooseCategoryTextField: UITextField!
    @IBOutlet var addAmountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField(dateTextField)
        setTextField(nameExpenceTextField)
        setTextField(chooseCategoryTextField)
        setTextField(addAmountTextField)
    }
    
    @IBAction func addAction() {
        dismiss(animated: true)
    }
    
    @IBAction func cancelAction() {
        dismiss(animated: true)
    }
    
    private func setTextField(_ textField: UITextField) {
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
    }
}
