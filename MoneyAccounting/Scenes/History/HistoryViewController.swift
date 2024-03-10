//
//  HistoryViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class HistoryViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var historyTableView: UITableView!
    
    var selectedIndex: Int!
    
    private var transactions: (dates: [Date], transactionArrays: [[Transaction]]) {
        let allTransactions = Person.getPerson().financialPortfolio.getAllTransactions()
        
        var dates: [Date] = []
        var transactionArrays: [[Transaction]] = []

        allTransactions.forEach { transaction in
            if let index = dates.firstIndex(of: transaction.date) {
                transactionArrays[index].append(transaction)
            } else {
                dates.append(transaction.date)
                transactionArrays.append([transaction])
            }
        }

        return (dates, transactionArrays)
    }
    
    private var incomeTransactions: (dates: [Date], transactionArrays: [[Transaction]]) {
        let allTransactions = Person.getPerson().financialPortfolio.getAllTransactions()
        
        var dates: [Date] = []
        var transactionArrays: [[Transaction]] = []

        allTransactions.forEach { transaction in
            if transaction.type == .income {
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
    
    private var expenseTransactions: (dates: [Date], transactionArrays: [[Transaction]]) {
        let allTransactions = Person.getPerson().financialPortfolio.getAllTransactions()
        
        var dates: [Date] = []
        var transactionArrays: [[Transaction]] = []

        allTransactions.forEach { transaction in
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
    
    private var targetTransactions: (dates: [Date], transactionArrays: [[Transaction]]) = ([],[])
    
    override func viewDidLoad() {
        setupNavigationTittle()
        setupBackBarButtonItem()
        setupFirstConfigSegmentedControl()
        segmentedControl.selectedSegmentIndex = selectedIndex
        historyTableView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        historyTableView.separatorColor = UIColor.lightGray.withAlphaComponent(0.3)
    }
    
    // MARK: IBActions
    @IBAction func segmentedControlAction() {
        historyTableView.reloadData()
    }
    
    @objc private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Private Methods
extension HistoryViewController {
    private func setupFirstConfigSegmentedControl() {
        let fontSize = UIFont.systemFont(ofSize: 10)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: fontSize], for: .normal)
        
        segmentedControl.layer.borderWidth = 5
        segmentedControl.layer.borderColor = UIColor(hex: "#F9F9FC").cgColor
        segmentedControl.setDividerImage(
            UIImage(),
            forLeftSegmentState: .normal,
            rightSegmentState: .normal,
            barMetrics: .default
        )
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
    
    func setupNavigationTittle() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationItem.hidesBackButton = false
        navigationItem.title = "История"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            targetTransactions = incomeTransactions
        case 1:
            targetTransactions = expenseTransactions
        default:
            targetTransactions = transactions
        }
        
        return targetTransactions.dates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        targetTransactions.transactionArrays[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryViewCell else {
            return UITableViewCell()
        }
        
        let transactions = targetTransactions.transactionArrays[indexPath.section]
        let transaction = transactions[indexPath.row]
        
        cell.descriptionLabel.text = transaction.description
        cell.categoryLabel.text = transaction.category.name
        
        if transaction.type == .income {
            cell.amountLabel.text = "+\(transaction.amount) \(transaction.currency)"
            cell.amountLabel.textColor = .green
        } else {
            cell.amountLabel.text = "-\(transaction.amount) \(transaction.currency)"
            cell.amountLabel.textColor = .red
        }
        
        cell.backgroundColor = UIColor(hex: "#F9F9FC")
        
        let cornerRadius: CGFloat = 10

        if tableView.numberOfRows(inSection: indexPath.section) == 1 {
            // Если в секции только одна ячейка, скругляем все углы
            cell.layer.cornerRadius = cornerRadius
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            if indexPath.row == 0 {
                // Скругление верхних углов первой ячейки
                cell.layer.cornerRadius = cornerRadius
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                // Скругление нижних углов последней ячейки
                cell.layer.cornerRadius = cornerRadius
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            } else {
                // Для остальных ячеек не применяем скругление углов
                cell.layer.cornerRadius = 0
                cell.layer.maskedCorners = []
            }
        }


        
        return cell
    }
    
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.textColor = .black
    }

}
    
// MARK: - CustomizableSegmentControl
final class CustomizableSegmentControl: UISegmentedControl {
    
    private lazy var radius: CGFloat = self.bounds.height / 2
    
    private var segmentInset: CGFloat = 0.1 {
        didSet {
            if segmentInset == 0 {
                segmentInset = 0.1
            }
        }
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor(hex: "#F9F9FC")
        
        // Background Radius
        self.layer.cornerRadius = self.radius
        self.layer.masksToBounds = true
        
        // Find selectedImageView
        let selectedImageViewIndex = numberOfSegments
        
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView {
            selectedImageView.backgroundColor = .white
            selectedImageView.tintColor = .black
            selectedImageView.image = nil
            
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = self.radius + 6
            
            // Fix weird effect
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
        }
    }
}
