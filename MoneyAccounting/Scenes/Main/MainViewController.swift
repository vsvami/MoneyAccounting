//
//  ViewController.swift
//  MoneyAccounting
//
//  Created by Vladimir Dmitriev on 05.03.24.
//

import UIKit

protocol DataViewControllerDelegate: AnyObject {
    func showDataMainVC()
}

final class MainViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var incomeLabel: UILabel!
    @IBOutlet var targetIncomeLabel: UILabel!
    @IBOutlet var expenseLabel: UILabel!
    @IBOutlet var targetExpenseLabel: UILabel!
    
    @IBOutlet var whiteView: UIView!
    @IBOutlet var greyView: UIView!
    
    @IBOutlet var categoriesTableView: UITableView!
    
    // MARK: - Private Properties
    private let categories = CategoriesStore.shared
    private let transactions = TransactionStore.shared
    private let personsStore = PersonsStore.shared
    
    private var sumIncomeTransactions: Double {
        transactions.getAllTransactions()
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
    }
    
    private var sumExpenseTransactions: Double {
        transactions.getAllTransactions()
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
    }
    
    // MARK: - View Life Cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBackground()
        setupNavigationBar()
        showDataMainVC()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        whiteView.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
        greyView.layer.cornerRadius = 15
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let historyVC = segue.destination as? HistoryViewController {
            if let senderButton = sender as? UIButton {
                if senderButton.tag == 0 {
                    historyVC.selectedIndex = 0
                } else {
                    historyVC.selectedIndex = 1
                }
            }
        }
        
        if segue.identifier == "toAddIncomeVC" {
            if let addIncomeVC = segue.destination as? AddIncomeViewController {
                addIncomeVC.delegate = self
            }
        }
        
        if segue.identifier == "toAddExpenseVC" {
            if let addExpenseVC = segue.destination as? AddExpenseViewController {
                addExpenseVC.delegate = self
            }
        }
        
        guard let indexPath = categoriesTableView.indexPathForSelectedRow else { return }
        
        if let categoryVC = segue.destination as? CategoryViewController {
            let selectedCategory = categories.categories[indexPath.row]
            categoryVC.category = selectedCategory
        }
        
    }
    
    // MARK: - Public Methods
    @objc func leftButtonTapped() {
        let storyboard = UIStoryboard(name: "Person", bundle: nil)
        let personVC = storyboard.instantiateViewController(
            withIdentifier: "PersonViewController"
        ) as! PersonViewController
        navigationController?.pushViewController(personVC, animated: true)
    }
    
    @objc func rightButtonTapped() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(
            withIdentifier: "SettingsViewController"
        ) as! SettingsViewController
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

// MARK: - Private Methods
private extension MainViewController {
    func setupBackground() {
        let backgroundImage = UIImage(named: "backgroundMain")
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.image = backgroundImage
        imageView.clipsToBounds = true
        
        view.insertSubview(imageView, at: 0)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .white
        navigationItem.hidesBackButton = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: nil,
            action: nil
        )
        
        // FIXME: - настройки для отображения фото в левой кнопке
        
//        let personButton = UIButton(type: .system)
//        personButton.setImage(
//            UIImage(named: "tc")?.withRenderingMode(.alwaysTemplate),
//            for: .normal
//        )
//        personButton.imageView?.contentMode = .scaleAspectFit
//        personButton.contentVerticalAlignment = .fill
//        personButton.contentHorizontalAlignment = .fill
//        personButton.addTarget(
//            self,
//            action: #selector(leftButtonTapped),
//            for: .touchUpInside
//        )
//                
//        let leftButton = UIBarButtonItem(customView: personButton)
//        
//        navigationItem.leftBarButtonItem = leftButton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person"),
            style: .plain,
            target: self,
            action: #selector(leftButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(rightButtonTapped)
        )
    }
}

// MARK: - DataViewControllerDelegate
extension MainViewController: DataViewControllerDelegate {
    func showDataMainVC() {
        title = personsStore.person.fullName
        
        balanceLabel.text = String(format: "%.2f", transactions.totalBalance())
        
        incomeLabel.text = "\(sumIncomeTransactions) \(transactions.categoriesStore.currentCurrency)"
        expenseLabel.text = "\(sumExpenseTransactions) \(transactions.categoriesStore.currentCurrency)"
        
        targetIncomeLabel.text = "\(GoalsStore.shared.goals.incomeGoal) \(transactions.categoriesStore.currentCurrency)"
        targetExpenseLabel.text = "\(GoalsStore.shared.goals.expenseLimit) \(transactions.categoriesStore.currentCurrency)"
        
        categoriesTableView.rowHeight = 50
        categoriesTableView.separatorColor = UIColor.lightGray.withAlphaComponent(0.3)
        categoriesTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.categories.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        
        let categoryCell = cell as? CategoryViewCell
        let category = categories.categories[indexPath.row]
        
        categoryCell?.categoryLabel.text = category.name
        
        let amountCategory = transactions.totalAmount(for: category, transactions: transactions.getAllTransactions())
        categoryCell?.amountCategoryLabel.text = "\(amountCategory) ₽"
        
        categoryCell?.gradientImageView.image = UIImage(named: category.colorImage)
        categoryCell?.iconImageView.image = UIImage(systemName: category.icon)
        categoryCell?.iconImageView.tintColor = .white
        
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = backgroundColorView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}
