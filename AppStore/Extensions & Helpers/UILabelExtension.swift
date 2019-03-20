//
//  UILabelExtension.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-16.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
}
