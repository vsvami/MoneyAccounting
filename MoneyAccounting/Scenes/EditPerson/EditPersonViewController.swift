//
//  EditPersonViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class EditPersonViewController: UIViewController {
    
    @IBOutlet var tableViewTV: UITableView!
    
    private let personStore = PersonsStore.shared
    private let usersStore = UsersStore.shared
    
    private var infoUser: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        tableViewTV.delegate = self
        tableViewTV.dataSource = self
        updateInfoUser()
    }
    
    private func updateInfoUser() {
        infoUser = [
            personStore.person.firstName,
            personStore.person.lastName,
            usersStore.users.email,
            String(usersStore.users.password.map { _ in "*" }),
        ]
    }
    
    @objc func saveButtonTapped() {
        var collectedData = [String: String]()
        
        for row in 0..<infoUser.count {
            if let cell = tableViewTV.cellForRow(at: IndexPath(row: row, section: 0)) as? EditPersonViewCell,
               let text = cell.enterTextField.text {
                switch row {
                case 0:
                    collectedData["firstName"] = text
                case 1:
                    collectedData["lastName"] = text
                case 2:
                    collectedData["email"] = text
                case 3:
                    collectedData["password"] = text
                default:
                    break
                }
            }
        }
        
        // Обновляеме person в DataStore
        if let firstName = collectedData["firstName"],
           let lastName = collectedData["lastName"],
           let email = collectedData["email"],
           let password = collectedData["password"] {
            
            // Обновляем данные person и user в DataStore
            personStore.person.firstName = firstName
            personStore.person.lastName = lastName
            usersStore.users.email = email
            usersStore.users.password = password
            
            navigationController?.popViewController(animated: true)
        }
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
        
        navigationItem.title = personStore.person.fullName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
        
        let saveBarButton = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        navigationItem.rightBarButtonItem = saveBarButton
        saveBarButton.tintColor = .systemBlue
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EditPersonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath)
        cell.tag = indexPath.row
        
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
        editPersonCell?.enterTextField.text = infoUser[indexPath.row]
        
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
