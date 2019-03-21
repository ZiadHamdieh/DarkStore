//
//  SearchController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-13.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class SearchController: BaseListController, UISearchBarDelegate {
    
    fileprivate let cellId = "cellId"
    fileprivate var searchResults = [Result]()
    
    fileprivate var timer: Timer?
    
    fileprivate let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search for apps"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let spinner: UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .black
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(spinner)
        spinner.fillSuperview()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.addSubview(searchLabel)
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            searchLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100)
            ])
        
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            searchLabel.isHidden = true
        }
        
        // introduce search throttling to avoid race conditions with search API
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.fetchApps(withSearchQuery: searchText)
        })
    }
    
    fileprivate func fetchApps(withSearchQuery query: String) {
        spinner.startAnimating()
        
        Service.shared.fetchApps(fromSearchQuery: query) { (results, error) in
            if let error = error {
                print("Failed to retrieve JSON: \(error)")
                return
            }
            
            self.searchResults = results?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.spinner.stopAnimating()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.appResult = searchResults[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchLabel.isHidden = searchResults.count != 0
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 325)
    }
    
}
