//
//  UIButtonExtension.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-18.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(title: String, cornerRadius: CGFloat) {
        self.init(type: .system )
        layer.cornerRadius = cornerRadius
        setTitle(title, for: .normal)
        setTitleColor(.blue, for: .normal)
        backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
}
