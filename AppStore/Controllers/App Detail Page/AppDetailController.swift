//
//  AppDetailController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-19.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController {
    
    let infoCellId = "infoCellId"
    let previewCellId = "previewCellId"
    let reviewCellId = "reviewCellId"
    
    var app: Result?
    var reviews: Reviews?
    
    fileprivate let appId: String
    
    // Dependency Injection Constructor
    init(appId: String) {
        self.appId = appId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: infoCellId)
        collectionView.register(AppPreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(AppReviewsCell.self, forCellWithReuseIdentifier: reviewCellId)
        
        fetchAppData()
    }
    
    fileprivate func fetchAppData() {
        
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        Service.shared.fetchJSON(fromUrlString: urlString) { (result: AppSearchResults?, error) in
            if let error = error {
                print("failed to fetch app JSON: ", error)
            }
            
            if let result = result {
                self.app = result.results.first
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        let reviewsUrlString = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
        print("appId = \(appId)")
        Service.shared.fetchJSON(fromUrlString: reviewsUrlString) { (reviews: Reviews?, error) in
            if let error = error {
                print("Failed to fetch reviews JSON: ", error)
                return
            }
            
            if let reviews = reviews {
                self.reviews = reviews
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellId, for: indexPath) as! AppDetailCell
            // this will trigger the property observer in AppDetailCell.swift
            cell.app = app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! AppPreviewCell
            cell.horizontalScreenshotController.app = app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! AppReviewsCell
            cell.reviewsController.reviews = reviews
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        
        if indexPath.item == 0 {
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 2000))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 2000))
            height = estimatedSize.height
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 300
        }
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 20, right: 0)
    }
    
}
