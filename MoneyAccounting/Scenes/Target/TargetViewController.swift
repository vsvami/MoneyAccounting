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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenceLimitButton.setOrdinaryButton()
        okayButton.setAccentButton()
        
        emotionImageView.image = UIImage(named: "sad")
    }
    
    @IBAction func doneAction() {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        let transactionStore = TransactionStore.shared
        
        let incomeTotal = transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
        let expenseTotal = transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
        
    }
}
