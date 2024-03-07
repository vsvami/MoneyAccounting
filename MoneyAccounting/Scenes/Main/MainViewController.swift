//
//  ViewController.swift
//  MoneyAccounting
//
//  Created by Vladimir Dmitriev on 05.03.24.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Public Properties
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var incomeLabel: UILabel!
    @IBOutlet var targetIncomeLabel: UILabel!
    @IBOutlet var expenseLabel: UILabel!
    @IBOutlet var targetExpenseLabel: UILabel!
    
    @IBOutlet var whiteView: UIView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        
        setupNavigationBar()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        whiteView.roundCorners(corners: [.topLeft, .topRight], radius: 15.0)
    }
    
    @objc func rightButtonTapped() {
    }
    @objc func leftButtonTapped() {
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
        navigationItem.title = "Tim Cook"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.titleView?.tintColor = .white
        
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(rightButtonTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(leftButtonTapped))
        
        //        let image = UIImage(named: "timcook")
        //        let leftButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightButtonTapped))
        //
        //        navigationItem.leftBarButtonItem = leftButton
                
    }
}
