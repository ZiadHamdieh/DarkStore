//
//  UIImageViewExtension.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-18.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

extension UIImageView {
    
    convenience init(cornerRadius: CGFloat = 12) {
        self.init()
        layer.cornerRadius = cornerRadius
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
}
