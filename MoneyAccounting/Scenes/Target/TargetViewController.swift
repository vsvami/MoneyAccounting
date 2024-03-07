//
//  TargetViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class TargetViewController: UIViewController {

    @IBOutlet var sadImageView: UIImageView!
    
    @IBOutlet var okayButton: UIButton!
    @IBOutlet var expenceLimitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenceLimitButton.layer.cornerRadius = expenceLimitButton.frame.height / 2
        expenceLimitButton.backgroundColor = UIColor(
            red: 249/255,
            green: 249/255,
            blue: 252/255,
            alpha: 1
        )
        
        okayButton.layer.cornerRadius = okayButton.frame.height / 2
        okayButton.backgroundColor = .systemBlue
    }
}
