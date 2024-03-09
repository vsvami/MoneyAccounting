//
//  EditPersonViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class EditPersonViewController: UIViewController {

    @IBOutlet var grayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grayView.layer.cornerRadius = 15
        setupNavigationBar()
    }
}

//MARK: - NavigationBar
extension EditPersonViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.tintColor = .systemBlue
        
        navigationItem.hidesBackButton = false
        
        navigationItem.title = "Tim Cook"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
}
