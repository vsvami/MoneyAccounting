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
}
