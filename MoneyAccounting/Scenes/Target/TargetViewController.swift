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
    @IBOutlet var descriptionLabel: UILabel!
    
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
            descriptionLabel.text = "Поздравляю, вы умеете добиваться своих целей, поставьте новые цели или просто похвалите себя"
        default:
            emotionImageView.image = UIImage(named: "sad")
            mainLabel.text = "Осторожно!"
            expenceLimitButton.setTitle("Изменить лимиты", for: .normal)
            okayButton.setTitle("Буду меньше тратить", for: .normal)
            descriptionLabel.text = "Так можно без штанов остаться! Если ваши доходы выросли и вы можете тратить больше увеличьте лимиты или тратьте меньше"
        }
    }
}
