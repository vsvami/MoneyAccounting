//
//  ViewController.swift
//  MoneyAccounting
//
//  Created by Vladimir Dmitriev on 05.03.24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var incomeLabel: UILabel!
    @IBOutlet var targetIncomeLabel: UILabel!
    @IBOutlet var expenseLabel: UILabel!
    @IBOutlet var targetExpenseLabel: UILabel!
    
    @IBOutlet var addIncomeButton: UIButton!
    @IBOutlet var addExpenseButton: UIButton!
    @IBOutlet var showIncomeButton: UIButton!
    @IBOutlet var showExpenseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

