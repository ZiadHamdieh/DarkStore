//
//  AppReviewsCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-20.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppReviewsCell: UICollectionViewCell {
    
    let ratingsLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 20))
    
    let reviewsController = ReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(ratingsLabel)
        ratingsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        addSubview(reviewsController.view)
        reviewsController.view.anchor(top: ratingsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
