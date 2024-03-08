//
//  ViewController.swift
//  MoneyAccounting
//
//  Created by Vladimir Dmitriev on 05.03.24.
//

import UIKit

final class MainViewController: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var incomeLabel: UILabel!
    @IBOutlet var targetIncomeLabel: UILabel!
    @IBOutlet var expenseLabel: UILabel!
    @IBOutlet var targetExpenseLabel: UILabel!
    
    @IBOutlet var whiteView: UIView!
    @IBOutlet var greyView: UIView!
    
    //MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tim Cook"
        setupBackground()
        setupNavigationBar()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        whiteView.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
//        greyView.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
        greyView.layer.cornerRadius = 15 // TODO: - fix
    }
    
    //MARK: - IB Actions
    @IBAction func addIncomeButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func addExpenseButton(_ sender: UIButton) {
        
    }
    
    @IBAction func showIncomeButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func showExpenseButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func addCategoryButtonTapped(_ sender: UIButton) {
        
    }
    
    
    //MARK: - Public Methods
    @objc func leftButtonTapped() {
        let storyboard = UIStoryboard(name: "Person", bundle: nil)
        let personVC = storyboard.instantiateViewController(withIdentifier: "PersonViewController") as! PersonViewController
        navigationController?.pushViewController(personVC, animated: true)
    }
    
    @objc func rightButtonTapped() {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
}

//MARK: - Private Methods
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
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        
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

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = "Cell index: \(indexPath.description)"
        
        return cell
    }
    
    // добавление удаление ячеек
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        <#code#>
    }
    // сортировка
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        <#code#>
    }
    
    // изменения индекса в массиве после сортировки
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        <#code#>
    }
}

extension MainViewController: UITableViewDelegate {
    
    
    
    
}
