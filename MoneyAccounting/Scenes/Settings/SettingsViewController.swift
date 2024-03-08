//
//  SettingsViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Properties
    var incomeGoal: Double? = 542.5  //Тестовое значение
    var expenseLimit: Double?
    
    //MARK: - IB Outlets
    
    @IBOutlet var incomeGoalTF: UITextField!
    @IBOutlet var expenseLimitTF: UITextField!
    
    @IBOutlet var grayView: UIView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grayView.layer.cornerRadius = 15
        configureTextFields()
        updateTextFields()
    }
    
    private func configureTextFields() {
        incomeGoalTF.setupTextField(leftText: "По доходу ₽", placeholder: "Введите цель")
        expenseLimitTF.setupTextField(leftText: "Лимит по расходам ₽", placeholder: "Введите лимит")
        
        incomeGoalTF.delegate = self
        expenseLimitTF.delegate = self
    }
    
    private func updateTextFields() {
        if let incomeGoal = incomeGoal {
            incomeGoalTF.text = "\(incomeGoal)"
        } else {
            incomeGoalTF.placeholder = "Введите цель"
        }
        
        if let expenseLimit = expenseLimit {
            expenseLimitTF.text = "\(expenseLimit)"
        } else {
            expenseLimitTF.placeholder = "Введите лимит"
        }
    }
    
    // MARK: IB Actions
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let incomeGoalText = incomeGoalTF.text, let incomeGoalValue = Double(incomeGoalText) {
            incomeGoal = incomeGoalValue
        }
        
        if let expenseLimitText = expenseLimitTF.text, let expenseLimitValue = Double(expenseLimitText) {
            expenseLimit = expenseLimitValue
        }
        
        // код для сохранения значений
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
func textFieldDidBeginEditing(_ textField: UITextField) {
    
    textField.rightViewMode = .never
}

func textFieldDidEndEditing(_ textField: UITextField) {
    guard let text = textField.text, !text.isEmpty else {
        textField.rightViewMode = .always
        return
    }
}

// MARK: - Extentions
extension UILabel {
    static func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }
}

extension UITextField {
    func setupTextField(leftText: String, placeholder: String) {
        self.textAlignment = .right
        self.leftView = UILabel.createLabel(withText: leftText)
        self.leftViewMode = .always
        self.placeholder = placeholder
        self.borderStyle = .none
        self.backgroundColor = .clear
    }
}

extension SettingsViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count > 0 {
            guard let oldText = textField.text, let stringRange = Range(range, in: oldText) else {
                return false
            }
            let newText = oldText.replacingCharacters(in: stringRange, with: string)
            if let _ = Double(newText) {
                return true
            } else {
                return false
            }
        }
        return true
    }
}
