//
//  MusicPageController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-23.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class MusicPageController: BaseListController {
    
    fileprivate let cellId = "cellId"
    fileprivate let footerCellId = "footerCellId"
    
    let searchTerm = "taylor"
    
    fileprivate var isPaginating = false
    fileprivate var isDonePaginating = false
    
    
    var results = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)
        
        fetchMusic()
    }
    
    fileprivate func fetchMusic() {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=25"
        Service.shared.fetchJSON(fromUrlString: urlString) { (searchResult: AppSearchResults?, error) in
            if let error = error {
                print("Failed to fetch tracks: ", error)
                return
            }
            
            guard let searchResult = searchResult else { return }
            self.results = searchResult.results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackCell
        let currentTrack = results[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: currentTrack.artworkUrl100))
        cell.titleLabel.text = currentTrack.trackName
        cell.subtitleLabel.text = "\(currentTrack.artistName ?? "") • \(currentTrack.collectionName ?? "")"
        
        // start pagination
        if indexPath.item == results.count - 1 && !isPaginating {
            isPaginating = true
            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=25"
            Service.shared.fetchJSON(fromUrlString: urlString) { (searchResult: AppSearchResults?, error) in
                if let error = error {
                    print("Failed to fetch tracks: ", error)
                    return
                }
                
                guard let searchResult = searchResult else { return }
                
                if searchResult.results.count == 0 {
                    self.isDonePaginating = true
                }
                
                self.results += searchResult.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.isPaginating = false
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellId, for: indexPath) as! MusicLoadingFooter
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = isDonePaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    
}
