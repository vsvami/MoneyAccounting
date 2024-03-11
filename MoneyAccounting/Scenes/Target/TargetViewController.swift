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
    
    @IBAction func limitButtonAction() {
        
        // Не реализован переход к целям
//        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
//        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
//        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    private func setupUI() {
        switch typeOfTransaction {
        case .income:
            emotionImageView.image = UIImage(named: "happy")
            mainLabel.text = "Красавчик!"
            expenceLimitButton.setTitle("Изменить цели", for: .normal)
            okayButton.setTitle("Да, я молодец", for: .normal)
        default:
            emotionImageView.image = UIImage(named: "sad")
            mainLabel.text = "Слишком много расходов"
            expenceLimitButton.setTitle("Изменить лимиты", for: .normal)
            okayButton.setTitle("Буду меньше тратить", for: .normal)
        }
    }
}
