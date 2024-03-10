//
//  HistoryViewController.swift
//  MoneyAccounting
//
//  Created by Иван Семикин on 05/03/2024.
//

import UIKit

final class HistoryViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        setupBackBarButtonItem()
        setupFirstConfigSegmentedControl()
        segmentedControl.selectedSegmentIndex = selectedIndex
    }
    
    // MARK: IBActions
    @IBAction func segmentedControlAction() {
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
