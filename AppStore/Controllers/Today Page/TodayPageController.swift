//
//  TodayPageController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-21.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TodayPageController: BaseListController {
    
    fileprivate let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.color = .darkGray
        view.startAnimating()
        view.hidesWhenStopped = true
        return view
    }()
    
    static let cellHeight: CGFloat = 500
    
    fileprivate var items = [TodayItem]()
    
//    fileprivate var items = [
//        TodayItem.init(category: "THE DAILY LIST", title: "Test-Drive These CarPlay Apps", image: #imageLiteral(resourceName: "garden"), summary: "ajdlkajdlakdjkalsdjksdjkaldjaskljaskldjaldjaslkdjakldjkl", backgroundColor: .white, cellType: .multipleApp),
//        TodayItem.init(category: "LIFE HACK", title: "TRAVEL ON A BUDGET", image: #imageLiteral(resourceName: "garden"), summary: "Find out all about how you need to travel without packing", backgroundColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), cellType: .singleApp),
//        TodayItem.init(category: "HOLIDAYS", title: "TRAVEL ON A BUDGET", image: #imageLiteral(resourceName: "holiday"), summary: "Find out all about how you need to travel without packing", backgroundColor: #colorLiteral(red: 0.9862952828, green: 0.9632481933, blue: 0.7315776944, alpha: 1), cellType: .singleApp)
//        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9538187385, green: 0.948759377, blue: 0.957450211, alpha: 1)
        
        view.addSubview(spinner)
        spinner.centerInSuperview()
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.cellType.singleApp.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.cellType.multipleApp.rawValue)
        
        fetchApps()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // fixes bug where tabBar moves out of place after view re-appears
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    fileprivate func fetchApps() {
        
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            if let error = error {
                print("Failed to fetch top grossing in today controller: ", error)
                return
            }
                
                guard let appGroup = appGroup else { return }
                topGrossingGroup = appGroup
                dispatchGroup.leave()
            }
        
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            if let error = error {
                print("Failed to fetch games in Today controller: ", error)
                return
            }
    
            guard let appGroup = appGroup else { return }
            gamesGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
             if let group = topGrossingGroup {
                let newItem = TodayItem.init(category: "DAILY LIST", title: group.feed.title, image: #imageLiteral(resourceName: "close_button"), summary: "", backgroundColor: .white, apps: group.feed.results, cellType: .multipleApp)
                self.items.append(newItem)
            }
            if let group = gamesGroup {
                let newItem = TodayItem.init(category: "DAILY LIST", title: group.feed.title, image: #imageLiteral(resourceName: "close_button"), summary: "", backgroundColor: .white, apps: group.feed.results, cellType: .multipleApp)
                self.items.append(newItem)
            }
            self.spinner.stopAnimating()
            self.collectionView.reloadData()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = items[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 0.9 * view.frame.width, height: TodayPageController.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    var todayAppController: TodayDetailAppController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if items[indexPath.item].cellType == .multipleApp {
            let fullViewController = TodayMultipleAppsController(mode: .fullScreen)
            fullViewController.results = items[indexPath.item].apps
//            fullViewController.collectionView.isScrollEnabled = true
            present(fullViewController, animated: true, completion: nil)
//            navigationController?.pushViewController(fullViewController, animated: true)
            return
        }
        
        let todayAppController = TodayDetailAppController()
        todayAppController.dismissHandler = {
            self.handleRemoveView()
        }
        todayAppController.view.layer.cornerRadius = 15
        todayAppController.todayItem = items[indexPath.row]
        view.addSubview(todayAppController.view)
        addChild(todayAppController)
        self.todayAppController = todayAppController
        collectionView.isUserInteractionEnabled = false
        guard let currentCell = collectionView.cellForItem(at: indexPath) else { return }
        // we actually need the cell's absolute coordinates
        guard let startingFrame = currentCell.superview?.convert(currentCell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        // auto layout constraint animation
        todayAppController.view.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = todayAppController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = todayAppController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = todayAppController.view.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = todayAppController.view.heightAnchor.constraint(equalToConstant: startingFrame.height )
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({ $0?.isActive = true })
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
 
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cell = todayAppController.tableView.cellForRow(at: [0,0]) as? TodayAppHeaderCell else {
                return
            }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    var startingFrame: CGRect?
    
    @objc fileprivate func handleRemoveView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.todayAppController.tableView.contentOffset = .zero
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = .identity
            
            guard let cell = self.todayAppController.tableView.cellForRow(at: [0,0]) as? TodayAppHeaderCell else {
                return
            }
            cell.todayCell.topConstraint.constant = 24
            
        }, completion: { _ in
            self.todayAppController.removeFromParent()
            self.todayAppController.view.removeFromSuperview()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
}
