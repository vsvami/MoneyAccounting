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
    
    let transationStore = TransactionStore.shared
    var transaction: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextField(nameExpenceTextField, withText: "Название расхода")
        setTextField(addAmountTextField, withText: "Введите сумму")
        
        dateButton.setOrdinaryButton()
        chooseCategoryButton.setOrdinaryButton()
        
        addButton.setAccentButton()
        
        transaction?.type = .expense
        transaction?.currency = CategoriesStore.shared.currency[0]
        
        
        showTargetVC()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func addAction() {
        if let transaction {
            transationStore.addTransaction(transaction)
        }
        
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
    
    private func showTargetVC() {
        let transactionStore = TransactionStore.shared
        let goalsStore = GoalsStore.shared
        
        let transactions = transactionStore.getAllTransactions()
        
        let incomeTotal = transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
        let expenseTotal = transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
        
        let incomeGoal = goalsStore.goals.incomeGoal
        let expenseLimit = goalsStore.goals.expenseLimit
        
        if incomeTotal > incomeGoal || expenseTotal > expenseLimit {
            let storyboard = UIStoryboard(name: "Target", bundle: nil)
            let targetVC = storyboard.instantiateViewController(withIdentifier: "TargetViewController") as! AddExpenseViewController
            present(targetVC, animated: true, completion: nil)
        }
    }
    
    private func showAlert(withTitle title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField?.text = "0.50"
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension AddExpenseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case addAmountTextField:
            guard let text = Double(textField.text ?? "") else {
                showAlert(withTitle: "Wrong format!", andMessage: "Please enter correct value")
                return
            }
            transaction?.amount = text
        default:
            guard let text = textField.text else {
                showAlert(withTitle: "Wrong format!", andMessage: "Please enter correct value")
                return
            }
            transaction?.description = text
        }
    }
    
    
}
