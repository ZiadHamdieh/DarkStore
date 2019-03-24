//
//  TrackCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-23.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView(cornerRadius: 12)
        iv.constrainWidth(constant: 80)
        iv.constrainHeight(constant: 80)
        iv.image = #imageLiteral(resourceName: "music")
        return iv
    }()
    
    let titleLabel = UILabel(text: "Track Name", font: .boldSystemFont(ofSize: 16))
    let subtitleLabel = UILabel(text: "subtitle", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    let separatorView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return sv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubViews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                titleLabel,
                subtitleLabel
                ], spacing: 4)
            ], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
        
        addSubview(separatorView)
        separatorView.anchor(
            top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: -8, right: 0),
            size: .init(width: frame.width, height: 0.5))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
