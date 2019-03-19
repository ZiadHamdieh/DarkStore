//
//  CollectionViewController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-19.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    
    init() {
        let layout = CollectionViewSnappingLayout()

        super.init(collectionViewLayout: layout)

        layout.scrollDirection = .horizontal
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
