//
//  AppHeaderCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-18.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppsPageHeaderCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 12)
    let highlightAppLabel = UILabel(text: "facebook", font: .boldSystemFont(ofSize: 16))
    let highlightDescriptionLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        highlightAppLabel.textColor = .blue
        highlightDescriptionLabel.numberOfLines = 2
        imageView.backgroundColor = .black
        
        let stackView = VerticalStackView(arrangedSubviews: [highlightAppLabel, highlightDescriptionLabel, imageView], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
