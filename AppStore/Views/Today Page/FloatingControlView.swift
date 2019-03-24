//
//  FloatingControlView.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-23.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class FloatingControlView: UIView {
    
    var todayItem: TodayItem! {
        didSet {
            imageView.image = todayItem?.image
        }
    }
    
    fileprivate let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
    fileprivate let titleLabel = UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18))
    fileprivate let subtitleLabel = UILabel(text: "Using your time", font: .systemFont(ofSize: 18))
    
    fileprivate let getButton: UIButton = {
        let button = UIButton(title: "GET", cornerRadius: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.constrainWidth(constant: 60)
        return button
    }()
    
    fileprivate let imageView: UIImageView = {
        let iv = UIImageView(cornerRadius: 12)
        iv.constrainWidth(constant: 60)
        iv.constrainHeight(constant: 60)
        return iv
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        clipsToBounds = true
        
        addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        
        let stackView = UIStackView(arrangedSubViews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                titleLabel,
                subtitleLabel
                ], spacing: 4),
            UIView(),
            getButton
            ], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
