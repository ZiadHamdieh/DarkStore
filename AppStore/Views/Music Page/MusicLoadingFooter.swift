//
//  MusicLoadingFooter.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-23.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = .darkGray
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        
        let label = UILabel(text: "Loading More...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        
        let stackView = VerticalStackView(arrangedSubviews: [
            spinner,
            label
            ], spacing: 8)
        addSubview(stackView)
        
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
