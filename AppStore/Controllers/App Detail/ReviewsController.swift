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
    
    var reviews: Reviews? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.feed.entry.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewCell
        let currentReview = reviews?.feed.entry[indexPath.item]
        cell.reviewAuthorLabel.text = currentReview?.author.name.label
        cell.reviewBodyLabel.text = currentReview?.content.label
        cell.reviewTitleLabel.text = currentReview?.title.label
        
        for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
            if let rating = Int(currentReview!.rating.label) {
                view.alpha = (index >= rating) ? 0 : 1
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
