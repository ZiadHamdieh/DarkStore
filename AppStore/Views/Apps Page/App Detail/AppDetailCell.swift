//
//  AppDetailCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-20.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    var app: Result! {
        didSet {
            appArtworkImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            appNameLabel.text = app?.trackName
            appDescriptionLabel.text = app?.description
            priceButton.setTitle(app?.formattedPrice, for: .normal)
            releaseNotes.text = app?.releaseNotes
        }
    }
    
    let appArtworkImageView: UIImageView = {
        let iv = UIImageView(cornerRadius: 15)
        iv.widthAnchor.constraint(equalToConstant: 150).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 150).isActive = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let appNameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 20), numberOfLines: 2)
    let appDescriptionLabel: UILabel = {
        let label = UILabel(text: "App Description", font: .systemFont(ofSize: 14), numberOfLines: 3)
        label.textColor = .darkGray
        return label
    }()
    let priceButton: UIButton = {
        let button = UIButton(title: "$4.99", cornerRadius: 16)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        return button
    }()
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 18))
    let releaseNotes = UILabel(text: "release notes release notesrelease notesrelease notesrelease notes ", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubViews: [
                appArtworkImageView,
                VerticalStackView(arrangedSubviews: [
                    appNameLabel,
                    appDescriptionLabel,
                    UIStackView(arrangedSubviews: [priceButton, UIView()]), UIView()], spacing: 12)], spacing: 12),
            whatsNewLabel,
            releaseNotes,
            ], spacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
