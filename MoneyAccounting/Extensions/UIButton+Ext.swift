//
//  UIButton+Ext.swift
//  MoneyAccounting
//
//  Created by Tatiana Lazarenko on 3/8/24.
//

import UIKit

extension UIButton {
    func setAccentButton() {
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = .systemBlue
        self.setTitleColor(
            UIColor(
                red: 255/255,
                green: 255/255,
                blue: 255/255,
                alpha: 1
            ),
            for: .normal
        )
    }
    
    func setOrdinaryButton() {
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = UIColor(
            red: 249/255,
            green: 249/255,
            blue: 252/255,
            alpha: 1
        )
        self.setTitleColor(
            UIColor(
                red: 134/255,
                green: 143/255,
                blue: 165/255,
                alpha: 1
            ),
            for: .normal
        )
    }
}
