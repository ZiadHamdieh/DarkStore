//
//  ReviewsController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-20.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let reviewCellId = "reviewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
}
