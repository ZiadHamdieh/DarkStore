//
//  UIStackViewExtension.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-20.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubViews: [UIView], spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubViews)
        self.spacing = spacing
    }
    
}
