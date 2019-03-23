//
//  BaseTodayCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-22.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    
    var todayItem: TodayItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        layer.cornerRadius = 15
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
