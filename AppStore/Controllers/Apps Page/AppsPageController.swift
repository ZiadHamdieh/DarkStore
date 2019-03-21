//
//  AppsController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-16.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    var groups = [AppGroup]()
    var headerGroup = [HeaderResult]()
    
    let spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .black
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        view.addSubview(spinner)
        spinner.fillSuperview()
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        var gamesGroup: AppGroup?
        var topGrossingGroup: AppGroup?
        var freeAppsGroup: AppGroup?
        var paidAppsGroup: AppGroup?
        
        // we want the data fetches to be synced together
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            dispatchGroup.leave()
            gamesGroup = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            dispatchGroup.leave()
            topGrossingGroup = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFreeIPhoneApps { (appGroup, error) in
            dispatchGroup.leave()
            freeAppsGroup = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPaidIPhoneApps { (appGroup, error) in
            dispatchGroup.leave()
            paidAppsGroup = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchHeaderApps { (result, error) in
            dispatchGroup.leave()
            if let error = error {
                print("Failed to fetch header apps: ", error)
                return
            }

            self.headerGroup = result ?? []
            
        }
        
        dispatchGroup.notify(queue: .main) {
            if let group1 = gamesGroup {
                self.groups.append(group1)
            }
            if let group2 = topGrossingGroup {
                self.groups.append(group2)
            }
            if let group3 = freeAppsGroup {
                self.groups.append(group3)
            }
            if let group4 = paidAppsGroup {
                self.groups.append(group4)
            }
            self.collectionView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        let appGroup = groups[indexPath.item]
        cell.titleLabel.text =  appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        // need to refresh controller's data so that numberOfItemsInSection runs again
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            let appController = AppDetailController(appId: feedResult.id)
            appController.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(appController, animated: true)
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.horizontalController.headerGroup = headerGroup
        header.horizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }

}
