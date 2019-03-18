//
//  AppsPageHeader.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-18.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    let horizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        addSubview(horizontalController.view)
        horizontalController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
