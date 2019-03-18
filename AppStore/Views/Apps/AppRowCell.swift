//
//  AppRowsCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-18.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let appImageView = UIImageView(cornerRadius: 12)
    
    let appNameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let appAuthorLabel = UILabel(text: "Company name", font: .systemFont(ofSize: 10))
    
    let getButton = UIButton(title: "GET", cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appImageView.backgroundColor = .black
        appImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        
        getButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        getButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        appAuthorLabel.textColor = UIColor(white: 0.50, alpha: 1)
        
        let appInfoStackView = VerticalStackView(arrangedSubviews: [appNameLabel, appAuthorLabel], spacing: 4)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [appImageView, appInfoStackView, getButton])
        addSubview(horizontalStackView)
        horizontalStackView.fillSuperview()
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 16
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
