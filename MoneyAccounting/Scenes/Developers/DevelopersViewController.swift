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
        dariaImageView.image = UIImage(named: "daria")
        ivanImageView.image = UIImage(named: "ivan")
        
        alexeyImageView.layer.cornerRadius = alexeyImageView.frame.height / 2
        nikitaImageView.layer.cornerRadius = nikitaImageView.frame.height / 2
        tatianaImageView.layer.cornerRadius = tatianaImageView.frame.height / 2
        vladimirImageView.layer.cornerRadius = vladimirImageView.frame.height / 2
        dariaImageView.layer.cornerRadius = dariaImageView.frame.height / 2
        ivanImageView.layer.cornerRadius = ivanImageView.frame.height / 2
        
        donationButton.setAccentButton()
    }
    
    @IBAction func closeButtonAction() {
        dismiss(animated: true)
    }
    
    @IBAction func donationButtonAction() {
        let alert = UIAlertController(
            title: "Спасибо за донат",
            message: "Мы рады, что вам нравится наше приложение",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
