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
    
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0 ..< 5).forEach({ _ in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 20)
            imageView.constrainHeight(constant: 20)
            arrangedSubviews.append(imageView)
        })
        // dummy view so that last star in arrangedSubviews maintains correct size
        arrangedSubviews.append(UIView())
        let sv = UIStackView(arrangedSubviews: arrangedSubviews)
        return sv
    }()
    
    let reviewBodyLabel = UILabel(text: "", font: .systemFont(ofSize: 20), numberOfLines: 5)
    
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
            starsStackView,
            reviewBodyLabel], spacing: 12)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
