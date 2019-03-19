//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-17.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseListController {
    
    fileprivate let topBottomCellPadding: CGFloat = 12
    fileprivate let lineSpacing: CGFloat = 10
    
    fileprivate let cellId = "cellId"
    
    var appGroup: AppGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            
        }
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        let result = appGroup?.feed.results[indexPath.item]
        cell.appNameLabel.text = result?.name
        cell.appAuthorLabel.text = result?.artistName
        cell.appImageView.sd_setImage(with: URL(string: result?.artworkUrl100 ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * topBottomCellPadding - 2 * lineSpacing) / 3
        return .init(width: 0.9 * view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
}
