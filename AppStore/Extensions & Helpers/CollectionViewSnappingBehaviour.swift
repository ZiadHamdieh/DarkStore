//
//  CollectionViewSnappingBehaviour.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-19.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit


// collectionView snapping behaviour
class CollectionViewSnappingLayout: UICollectionViewFlowLayout {
    
    // from https://stackoverflow.com/questions/33855945/uicollectionview-snap-onto-cell-when-scrolling-horizontally
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
    
    var offsetAdjustment = CGFloat.greatestFiniteMagnitude
    let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
    
    let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    
    let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
    
    layoutAttributesArray?.forEach({ (layoutAttributes) in
    let itemOffset = layoutAttributes.frame.origin.x
    if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
    offsetAdjustment = itemOffset - horizontalOffset
    }
    })
    
    return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
