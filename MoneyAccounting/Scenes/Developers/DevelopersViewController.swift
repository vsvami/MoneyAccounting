//
//  DevelopersViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

class DevelopersViewController: UIViewController {

    @IBOutlet var alexeyImageView: UIImageView!
    @IBOutlet var nikitaImageView: UIImageView!
    @IBOutlet var dariaImageView: UIImageView!
    @IBOutlet var tatianaImageView: UIImageView!
    @IBOutlet var vladimirImageView: UIImageView!
    @IBOutlet var ivanImageView: UIImageView!
    
    @IBOutlet var donationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alexeyImageView.image = UIImage(named: "alexey")
        nikitaImageView.image = UIImage(named: "nikita")
        tatianaImageView.image = UIImage(named: "tatiana")
        vladimirImageView.image = UIImage(named: "vladimir")
        dariaImageView.image = UIImage(named: "tc")
        ivanImageView.image = UIImage(named: "tc")
        
        alexeyImageView.layer.cornerRadius = alexeyImageView.frame.height / 2
        nikitaImageView.layer.cornerRadius = nikitaImageView.frame.height / 2
        tatianaImageView.layer.cornerRadius = tatianaImageView.frame.height / 2
        vladimirImageView.layer.cornerRadius = vladimirImageView.frame.height / 2
        
        donationButton.backgroundColor = UIColor(
            red: 249/255,
            green: 249/255,
            blue: 252/255,
            alpha: 1
        )
        donationButton.layer.cornerRadius = donationButton.frame.height / 2
    }
}
