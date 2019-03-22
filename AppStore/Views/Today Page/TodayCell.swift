//
//  TodayCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-21.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "UTILIZING YOUR TIME", font: .boldSystemFont(ofSize: 28))
    let summaryLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 18), numberOfLines: 3)
    
    var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            summaryLabel.text = todayItem.summary
            backgroundColor = todayItem.backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 18
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            imageContainerView,
            summaryLabel
            ], spacing: 8)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
