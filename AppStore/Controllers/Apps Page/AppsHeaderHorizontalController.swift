//
//  AppsHeaderHorizontalController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-18.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var headerGroup = [HeaderResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(AppsPageHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerGroup.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsPageHeaderCell
        let appGroup = headerGroup[indexPath.item]
        cell.highlightAppLabel.text = appGroup.name
        cell.highlightDescriptionLabel.text = appGroup.tagline
        cell.imageView.sd_setImage(with: URL(string: appGroup.imageUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 0.9 * view.frame.width, height: view.frame.height)
    }
    
}
