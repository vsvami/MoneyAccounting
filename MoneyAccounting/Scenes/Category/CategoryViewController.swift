//
//  CategoryViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var category: Category!
        
    private var transactions: [Date: [Transaction]] {
        let allTransactions = Person.getPerson().financialPortfolio.transactions(for: category.name, from: Person.getPerson().financialPortfolio.getAllTransactions())
        var transactions: [Date: [Transaction]] = [:]
        
        allTransactions.forEach { transaction in
            if var existingTransactions = transactions[transaction.date] {
                existingTransactions.append(transaction)
                transactions[transaction.date] = existingTransactions
            } else {
                transactions[transaction.date] = [transaction]
            }
        }

        return transactions
    }

    @IBOutlet var categoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = category.name
        setupBackBarButtonItem()
        
        print(transactions)
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupBackBarButtonItem() {
        let arrowImage = UIImage(systemName: "chevron.backward")
        
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

// MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        transactions.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = Array(transactions.keys)
        let date = keys[section]
        
        return transactions[date]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let date = Array(transactions.keys)[indexPath.section]
        
        if let transactionsForDate = transactions[date] {
            let transaction = transactionsForDate[indexPath.row]
            
            var content = cell.defaultContentConfiguration()
            content.text = transaction.description
            content.textProperties.font = UIFont.systemFont(ofSize: 14)
            
            content.secondaryText = "-\(String(transaction.amount)) \(transaction.currency)"
            content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 18)
            content.secondaryTextProperties.color = .red
            
            cell.contentConfiguration = content
            cell.contentView.backgroundColor = UIColor(hex: "#F9F9FC")
        }
        
        let cornerRadius: CGFloat = 10
        let maskLayer = CAShapeLayer()
        
        if tableView.numberOfRows(inSection: indexPath.section) == 1 {
            // Если в секции только одна ячейка, скругляем все углы
            let bounds = cell.bounds
            let rectPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            maskLayer.path = rectPath.cgPath
        } else {
            if indexPath.row == 0 {
                // Скругление верхних углов первой ячейки
                let bounds = cell.bounds
                let rectPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                maskLayer.path = rectPath.cgPath
            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // Скругление нижних углов последней ячейки
                let bounds = cell.bounds
                let rectPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                maskLayer.path = rectPath.cgPath
            } else {
                // Для остальных ячеек не применяем скругление углов
                maskLayer.path = UIBezierPath(rect: cell.bounds).cgPath
            }
        }
        
        cell.layer.mask = maskLayer
        
        return cell
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.width - 20, height: 40))
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        
        let date = Array(transactions.keys)[section]
        if let transactionsForDate = transactions[date], !transactionsForDate.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "dd MMMM yy"
            label.text = dateFormatter.string(from: date)
        } else {
            label.text = ""
        }
        
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
