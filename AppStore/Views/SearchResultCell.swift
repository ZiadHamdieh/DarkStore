//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-14.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    // We can force unwrap here because we know Result will always be non-nil
    var appResult: Result! {
        didSet {
            appNameLabel.text = appResult.trackName
            imageView.sd_setImage(with: URL(string: appResult.artworkUrl512))
            screenshot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            if appResult.screenshotUrls.count > 1 {
                screenshot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }
            if appResult.screenshotUrls.count > 2 {
                screenshot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
            appGenreLabel.text = appResult.primaryGenreName
            appRatingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let appGenreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let appRatingsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var screenshot1ImageView = createScreenshotImageView()
    lazy var screenshot2ImageView = createScreenshotImageView()
    lazy var screenshot3ImageView = createScreenshotImageView()

    fileprivate func createScreenshotImageView() -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        return iv
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let screenshotStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        screenshotStackView.spacing = 10
        screenshotStackView.distribution = .fillEqually
        
        let appInfoStackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [appNameLabel, appGenreLabel, appRatingsLabel]),
            getButton])
        appInfoStackView.alignment = .center
        appInfoStackView.spacing = 10
        
        let overallStackView = VerticalStackView(arrangedSubviews: [appInfoStackView, screenshotStackView], spacing: 15)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overallStackView)
        
        NSLayoutConstraint.activate([
            overallStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15.0),
            overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0),
            overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15.0),
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
