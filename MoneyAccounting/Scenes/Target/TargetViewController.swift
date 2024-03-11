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
    
    var typeOfTransaction: TransactionType!
    
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

        switch typeOfTransaction {
        case .income:
                emotionImageView.image = UIImage(named: "happy")
                mainLabel.text = "Красавчик!"
        default:
                emotionImageView.image = UIImage(named: "sad")
                mainLabel.text = "Слишком много расходов"
        }
//        if incomeTotal > incomeGoal {
//            emotionImageView.image = UIImage(named: "happy")
//            mainLabel.text = "Красавчик!"
//        } else if expenseTotal > expenseLimit {
//            emotionImageView.image = UIImage(named: "sad")
//            mainLabel.text = "Слишком много расходов"
//        }
    }
}
