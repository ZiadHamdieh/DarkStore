//
//  ReviewCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-20.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
