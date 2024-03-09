//
//  TargetViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class TargetViewController: UIViewController {

    @IBOutlet var emotionImageView: UIImageView!
    
    @IBOutlet var okayButton: UIButton!
    @IBOutlet var expenceLimitButton: UIButton!
    
    @IBOutlet var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenceLimitButton.setOrdinaryButton()
        okayButton.setAccentButton()
        
        setupUI()
    }
    
    @IBAction func doneAction() {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        let transactionStore = TransactionStore.shared
        let goalsStore = GoalsStore.shared
        
        let transactions = transactionStore.getAllTransactions()
        
        let incomes = transactions.filter({ $0.type == .income })
        let incomeTotal = incomes.reduce(0) { $0 + $1.amount }
        
        let expenses = transactions.filter { $0.type == .expense }
        let expenseTotal = expenses.reduce(0) { $0 + $1.amount }
        
        let incomeGoal = goalsStore.goals.incomeGoal
        let expenseLimit = goalsStore.goals.expenseLimit
        
        if expenseTotal > expenseLimit {
            emotionImageView.image = UIImage(named: "sad")
            mainLabel.text = "Слишком много расходов"
        }
        
        if incomeTotal > incomeGoal {
            emotionImageView.image = UIImage(named: "happy")
            mainLabel.text = "Красавчик!"
        }
        
    }
}
