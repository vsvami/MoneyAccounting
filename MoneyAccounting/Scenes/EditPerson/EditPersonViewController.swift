//
//  EditPersonViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class EditPersonViewController: UIViewController {
    
    @IBOutlet var tableViewTV: UITableView!
    
    private var person = Person.getPerson()
    
    private var infoUser: [String: String] {
        let name = Person.getPerson().firstName
        let surname = Person.getPerson().lastName
        let email = User.getUser().email
        let password = String(User.getUser().password.map { _ in "*" })
        
        return ["Имя": name, "Фамилия": surname, "Почта": email, "Пароль": password]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        tableViewTV.delegate = self
        tableViewTV.dataSource = self
        
    }
    
    // MARK: - Overrides Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EditPersonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath)
        
        let editPersonCell = cell as? EditPersonViewCell
        
        let positions = ["Имя", "Фамилия", "Почта", "Пароль"]
        let target = positions[indexPath.row]
        editPersonCell?.dataLabel.text = target
        
        let placeholders = ["Введите имя", "Введите фамилию", "Введите почту", "Введите телефон"]
        editPersonCell?.enterTextField.attributedPlaceholder = NSAttributedString(
            string: placeholders[indexPath.row],
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(
                named: "customDarkGray"
            ) ?? .customDarkGray]
        )
        
        
        cell.contentView.backgroundColor = UIColor(hex: "#F9F9FC")
        
        let cornerRadius: CGFloat = 10
        let maskLayer = CAShapeLayer()
       
        if tableView.numberOfSections == 1 && tableView.numberOfRows(inSection: indexPath.section) == 4 {
            if indexPath.row == 0 {
                // Скругление верхних углов первой ячейки
                let bounds = cell.bounds
                let rectPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                maskLayer.path = rectPath.cgPath
            } else if indexPath.row == 3 {
                // Скругление нижних углов последней ячейки
                let bounds = cell.bounds
                let rectPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                maskLayer.path = rectPath.cgPath
            } else {
                maskLayer.path = UIBezierPath(rect: cell.bounds).cgPath
            }
            cell.layer.mask = maskLayer
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}

// MARK: - UITextFieldDelegate
extension EditPersonViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
