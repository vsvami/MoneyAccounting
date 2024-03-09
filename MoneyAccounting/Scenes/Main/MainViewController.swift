//
//  ViewController.swift
//  MoneyAccounting
//
//  Created by Vladimir Dmitriev on 05.03.24.
//

import UIKit

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
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tim Cook"
        
        setupBackground()
        setupNavigationBar()
        
        categoriesTableView.rowHeight = 50
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        whiteView.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
        
        // FIXME: - исправить скругдения
//        greyView.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
        greyView.layer.cornerRadius = 15 // TODO: - fix
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = categoriesTableView.indexPathForSelectedRow else { return }
        
        if segue.identifier == "toCategoryVC" {
            let selectedCategory = categories.categories[indexPath.row]
            if let categoryVC = segue.destination as? CategoryViewController {
                categoryVC.category = selectedCategory
            }
        }
    }

    
//    // MARK: - IB Actions
    @IBAction func addIncomeButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func addExpenseButton(_ sender: UIButton) {
    }
    
    @IBAction func showIncomeButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func showExpenseButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func addCategoryButtonTapped(_ sender: UIButton) {
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

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        
        let categoryCell = cell as? CategoryViewCell
        let category = categories.categories[indexPath.row]
        
        categoryCell?.categoryLabel.text = category.name
        
        // FIXME: - временный код для UITableView+Ext
        categoryCell?.amountCategoryLabel.text = "3564 ₽"
        
        categoryCell?.gradientImageView.image = UIImage(named: category.colorImage)
        categoryCell?.iconImageView.image = UIImage(systemName: category.icon)
        categoryCell?.iconImageView.tintColor = .white
        
        // FIXME: - временный код для UITableView+Ext
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
//        
//        var content = cell.defaultContentConfiguration()
//        let category = categories.categories[indexPath.row]
//        
//        content.text = category.name
//        content.textProperties.font = UIFont.systemFont(ofSize: 14)
//        
//        content.secondaryText = "3564 ₽"
//        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 18)
//        content.secondaryTextProperties.color = UIColor.black
//        
//        content.image = UIImage(named: category.colorImage)
//        content.imageProperties.cornerRadius = tableView.rowHeight / 2
//        
//        cell.contentConfiguration = content
//        
//        // Проверка, является ли ячейка первой или последней в секции
//            if indexPath.row == 0 {
//                // Скругление верхних углов первой ячейки
//                cell.layer.cornerRadius = 20
//                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//                // Скругление нижних углов последней ячейки
//                cell.layer.cornerRadius = 20
//                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            } else {
//                // Сброс скругления для других ячеек
//                cell.layer.cornerRadius = 0
//                cell.layer.maskedCorners = []
//            }
        
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // FIXME: - временный код для UITableView+Ext
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        // установка хедера
//        let contentView = UIView()
//        let nameSection = UILabel(
//            frame: CGRect(
//                x: 20,
//                y: 15,
//                width: tableView.frame.width - 40,
//                height: 20
//            )
//        )
//        nameSection.text = "Header"
//        nameSection.font = UIFont.systemFont(ofSize: 18)
//        contentView.addSubview(nameSection)
//        
//        return contentView
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        50
//    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        // Установка цвета выделения ячейки, нужно для всех таблиц
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = backgroundColorView
    }
    
}
