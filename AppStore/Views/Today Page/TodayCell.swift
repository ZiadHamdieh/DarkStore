//
//  TodayCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-21.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 18
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.centerInSuperview(size: .init(width: 200, height: 200))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
