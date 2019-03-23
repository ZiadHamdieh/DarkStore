//
//  MultipleAppCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-22.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    
    var app: FeedResult! {
        didSet {
            appNameLabel.text = app.name
            appAuthorLabel.text = app.artistName
            appImageView.sd_setImage(with: URL(string: app.artworkUrl100))
        }
    }
    
    let appImageView = UIImageView(cornerRadius: 12)
    
    let appNameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let appAuthorLabel = UILabel(text: "Company name", font: .systemFont(ofSize: 10))
    
    let getButton = UIButton(title: "GET", cornerRadius: 15)
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        appImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        appImageView.image = #imageLiteral(resourceName: "garden")
        
        getButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        getButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        appAuthorLabel.textColor = UIColor(white: 0.50, alpha: 1)
        
        let appInfoStackView = VerticalStackView(arrangedSubviews: [appNameLabel, appAuthorLabel], spacing: 4)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [appImageView, appInfoStackView, getButton])
        addSubview(horizontalStackView)
        horizontalStackView.fillSuperview()
        horizontalStackView.distribution = .fillProportionally
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 16
        
        addSubview(separatorView)
        separatorView.anchor(
            top: nil, leading: appNameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: -8, right: 0),
            size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
