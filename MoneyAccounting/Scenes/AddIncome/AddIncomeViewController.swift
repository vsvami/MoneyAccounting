//
//  AddIncomeViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 06/03/2024.
//

import UIKit

final class AddIncomeViewController: UIViewController {

// MARK: - IB Outlets
    @IBOutlet var amountTF: UITextField!
    @IBOutlet var categoryTF: UITextField!
    @IBOutlet var dateTF: UITextField!
    @IBOutlet var descriptionTF: UITextField!
    
    @IBOutlet var addButton: UIButton!
    
// MARK: - Public Properties
    weak var delegate: DataViewControllerDelegate?
    var categoryNames: [String] = []
    
// MARK: - Private Properties
    private let transationStore = TransactionStore.shared
    private let categoriesStore = CategoriesStore.shared
    private var pickerView = UIPickerView()
    private let datePicker = UIDatePicker()
        
// MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
        setTextField(descriptionTF, withText: "Название дохода")
        setTextField(amountTF, withText: "Введите сумму")
        setTextField(categoryTF, withText: "Выберите категорию")
        setTextField(dateTF, withText: "Выберите дату")
        
        amountTF.inputAccessoryView = createToolbar()
        
        addButton.setAccentButton()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        descriptionTF.delegate = self
        amountTF.delegate = self
        categoryTF.delegate = self
        dateTF.delegate = self
        
        categoryTF.inputView = pickerView
    }

// MARK: - Overrides Methods
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
        }
     
// MARK: - IB Actions
    @IBAction func addAction() {
        // Делаем проверку полей транзакции
        guard let amount = Double(amountTF.text ?? "") else { return }
        let categoryFromList = categoriesStore.categories.first { category in
            category.name == categoryTF.text
        }
        guard let category = categoryFromList else { return }
        
        // Если все поля транзакции прошли проверку, то они добавляются в транзакцию
        let transaction = Transaction(
            type: .income,
            currency: categoriesStore.currency[0],
            amount: amount,
            category: category,
            date: datePicker.date,
            description: descriptionTF.text
        )
        // Добавляем транзакцию в хранилище
        transationStore.addTransaction(transaction)
        
        // Проверка на превышение лимита по расходам
        let transactionStore = TransactionStore.shared
        let goalsStore = GoalsStore.shared
        
        let transactions = transactionStore.getAllTransactions()
        let incomeTotal = transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
        let incomeGoal = goalsStore.goals.incomeGoal
        
        // Если расходы превысили лимит, открывается экран таргет
        if incomeTotal > incomeGoal {
            addButton.setOrdinaryButton()
            addButton.setTitle("Добавлено", for: .normal)
            addButton.isEnabled = false
            
            showTargetVC()
        } else {
            dismiss(animated: true)
        }
        
        delegate?.showDataMainVC()
    }
}

// MARK: - Private Methods
extension AddIncomeViewController {
    private func setTextField(_ textField: UITextField, withText placeholder: String) {
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        textField.setBorderStyle()
        textField.setCornerRadius()
        
        textField.backgroundColor = .customLightGray
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(
                named: "customDarkGray"
            ) ?? .customDarkGray]
        )
    }
    
    private func createDatePicker() {
        dateTF.textAlignment = .center
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolBar.setItems([doneButton], animated: true)
        
        dateTF.inputAccessoryView = toolBar
        dateTF.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    @objc private func doneButtonPressed() {
        let formattedDate = DateFormatter()
        formattedDate.dateStyle = .medium
        formattedDate.timeStyle = .none
        
        dateTF.text = formattedDate.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    private func showTargetVC() {
        let storyboard = UIStoryboard(name: "Target", bundle: nil)
        let targetVC = storyboard.instantiateViewController(withIdentifier: "TargetViewController") as! TargetViewController
        targetVC.typeOfTransaction = .income
        present(targetVC, animated: true, completion: nil)
    }
    
    private func showAlert(withTitle title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField?.text = "0.50"
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension AddIncomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case amountTF:
            guard (Double(textField.text ?? "") != nil) else {
                showAlert(withTitle: "Wrong format!", andMessage: "Please enter correct value")
                return
            }
        case descriptionTF, categoryTF:
            if (textField.text == "") {
                showAlert(withTitle: "Wrong format!", andMessage: "Please enter correct value")
                return
            }
        default:
            return
        }
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 44
            )
        )
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        toolbar.setItems([flexSpace, doneButton], animated: false)
        return toolbar
    }

    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension AddIncomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categoriesStore.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categoriesStore.categories.forEach { category in
            categoryNames.append(category.name)
        }
        
        return categoryNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTF.text = categoryNames[row]
    }
}
