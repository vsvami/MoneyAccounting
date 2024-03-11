//
//  CategoryViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var categoryTableView: UITableView!
    
    var category: Category!
    
    private var transactions: (dates: [Date], transactionArrays: [[Transaction]]) {
        let allTransactions = Person.getPerson().financialPortfolio.transactions(
            for: category.name,
            from: Person.getPerson().financialPortfolio.getAllTransactions()
        )
        let sortedTransactions = allTransactions.sorted { $0.date > $1.date }
        
        var dates: [Date] = []
        var transactionArrays: [[Transaction]] = []

        sortedTransactions.forEach { transaction in
            if transaction.type == .expense {
                if let index = dates.firstIndex(of: transaction.date) {
                    transactionArrays[index].append(transaction)
                } else {
                    dates.append(transaction.date)
                    transactionArrays.append([transaction])
                }
            }
        }

        return (dates, transactionArrays)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = category.name
        setupBackBarButtonItem()
        categoryTableView.separatorColor = UIColor.lightGray.withAlphaComponent(0.3)
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
        transactions.dates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.transactionArrays[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let transactionsForDate = transactions.transactionArrays[indexPath.section]
        let transaction = transactionsForDate[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = transaction.description
        content.textProperties.font = UIFont.systemFont(ofSize: 14)
        
        content.secondaryText = "-\(String(transaction.amount)) \(transaction.currency)"
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 18)
        content.secondaryTextProperties.color = .red
        
        cell.contentConfiguration = content
        cell.contentView.backgroundColor = UIColor(hex: "#F9F9FC")
        
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
                let rectPath = UIBezierPath(
                    roundedRect: bounds,
                    byRoundingCorners: [.topLeft, .topRight],
                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
                )
                maskLayer.path = rectPath.cgPath
            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // Скругление нижних углов последней ячейки
                let bounds = cell.bounds
                let rectPath = UIBezierPath(
                    roundedRect: bounds,
                    byRoundingCorners: [.bottomLeft, .bottomRight],
                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
                )
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

// MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = transactions.dates[section]
        let transactionsForDate = transactions.transactionArrays[section]
        
        if !transactionsForDate.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "dd MMMM yy"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.roundCorners(corners: .allCorners, radius: 10)
        header.textLabel?.textColor = .black
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
