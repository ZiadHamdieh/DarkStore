//
//  TodayCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-21.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
