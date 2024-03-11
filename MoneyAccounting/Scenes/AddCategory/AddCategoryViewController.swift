//
//  AddCategoryViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 08/03/2024.
//

import UIKit

final class AddCategoryViewController: UIViewController {

    @IBOutlet var addButton: UIButton!
    
    @IBOutlet var categoryTextField: UITextField!
    
    @IBOutlet var categoryImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.setAccentButton()
        setTextField(categoryTextField, withText: "Укажите название")
        
        let categories = CategoriesStore.shared.categories
        let category = categories.randomElement()
        let image = category?.colorImage
        categoryImageView.image = UIImage(named: image ?? "gradient1")
    }

    @IBAction func addAction() {
        dismiss(animated: true)
    }
    
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
}
