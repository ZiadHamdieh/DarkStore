//
//  AppDetailController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-19.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController {
    
    let cellId = "cellId"
    let previewId = "previewId"
    
    var app: Result?
    
    var appId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchJSON(fromUrlString: urlString) { (result: AppSearchResults?, error) in
                if let error = error {
                    print("failed to fetch app data: ", error)
                }
                
                if let result = result {
                    self.app = result.results.first
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailCell
        // this will trigger the property observer in AppDetailCell.swift
        cell.app = app
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 2000))
        dummyCell.app = app
        dummyCell.layoutIfNeeded()
        
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 2000))
        let estimatedHeight = estimatedSize.height
        
        return .init(width: view.frame.width, height: estimatedHeight)
    }
    
}
