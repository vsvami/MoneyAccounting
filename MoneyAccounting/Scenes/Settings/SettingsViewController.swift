//
//  SettingsViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Private Properties
    private var incomeGoal: Double?
    private var expenseLimit: Double?
    
    //MARK: - IB Outlets
    
    @IBOutlet var incomeGoalTF: UITextField!
    @IBOutlet var expenseLimitTF: UITextField!
    
    @IBOutlet var grayView: UIView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grayView.layer.cornerRadius = 15
        
        setupNavigationBar()
        
        configureTextFields()
        updateFinancialGoals()
        updateTextFields()
    }
    
    private func updateFinancialGoals() {
        let goalsStore = GoalsStore.shared
        incomeGoal = goalsStore.goals.incomeGoal
        expenseLimit = goalsStore.goals.expenseLimit
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
        if let incomeGoalText = incomeGoalTF.text, let incomeGoalValue = Double(incomeGoalText),
           let expenseLimitText = expenseLimitTF.text, let expenseLimitValue = Double(expenseLimitText) {
            
            incomeGoal = incomeGoalValue
            expenseLimit = expenseLimitValue
            
            GoalsStore.shared.goals.incomeGoal = incomeGoalValue
            GoalsStore.shared.goals.expenseLimit = expenseLimitValue
            
            navigationController?.popViewController(animated: true)
        }
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

//MARK: - NavigationBar
extension SettingsViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.tintColor = .systemBlue
        
        navigationItem.hidesBackButton = false
        
        navigationItem.title = "Параметры"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
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
    //Управляет вводом в текстовое поле, разрешая только числовые значения
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
