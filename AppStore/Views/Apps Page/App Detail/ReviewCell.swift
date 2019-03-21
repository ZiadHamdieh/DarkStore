//
//  ReviewCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-20.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let reviewTitleLabel = UILabel(text: "Ridiculous", font: .boldSystemFont(ofSize: 20))
    let reviewAuthorLabel = UILabel(text: "anon", font: .systemFont(ofSize: 20))
    let starsLabel = UILabel(text: "stars", font: .systemFont(ofSize: 16))
    let reviewBodyLabel = UILabel(text: "aslkdjaldjas", font: .systemFont(ofSize: 20), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        layer.cornerRadius = 15
        clipsToBounds = true
        
        reviewTitleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        reviewAuthorLabel.textAlignment = .right
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubViews: [
                reviewTitleLabel,
                reviewAuthorLabel
                ], spacing: 50),
            starsLabel,
            reviewBodyLabel], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        stackView.distribution = .fillEqually
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
