//
//  SearchController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-13.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit
import SDWebImage

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate var searchResults = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchApps()
        
    }
    
    fileprivate func fetchApps() {
        Service.shared.fetchApps { (results, error)  in
            if let error = error {
                print("Failed to retrieve apps: \(error)")
                return
            }
            
            self.searchResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        let appResult = searchResults[indexPath.item]
        cell.appNameLabel.text = appResult.trackName
        cell.imageView.sd_setImage(with: URL(string: appResult.artworkUrl512))
        cell.screenshot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
        if appResult.screenshotUrls.count > 1 {
            cell.screenshot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
        }
        if appResult.screenshotUrls.count > 2 {
            cell.screenshot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
        }
        cell.appGenreLabel.text = appResult.primaryGenreName
        cell.appRatingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 325)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
