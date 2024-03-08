//
//  CategoryViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet var categoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackBarButtonItem()
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupBackBarButtonItem() {
        let arrowImage = UIImage(systemName: "arrow.backward")
        
        let backButton = UIButton(type: .system)
        backButton.setImage(arrowImage, for: .normal)
        backButton.setTitle("Назад", for: .normal)
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.tintColor = .systemBlue
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
}
