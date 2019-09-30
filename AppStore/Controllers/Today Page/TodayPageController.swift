//
//  TodayPageController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-21.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TodayPageController: BaseListController, UIGestureRecognizerDelegate {
    
    fileprivate let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.color = .darkGray
        view.startAnimating()
        view.hidesWhenStopped = true
        return view
    }()
    
    static let cellHeight: CGFloat = 500
    
    fileprivate var items = [TodayItem]()
    
    fileprivate let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9538187385, green: 0.948759377, blue: 0.957450211, alpha: 1)
        
        view.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        blurVisualEffectView.alpha = 0
        
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
            self.items.append(TodayItem.init(category: "LIFE AT APPLE", title: "LOREM IPSUM DOLOR", image: #imageLiteral(resourceName: "appleLogo"), summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", backgroundColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), apps: nil, cellType: .singleApp))
            
            if let group = topGrossingGroup {
                let newItem = TodayItem.init(category: "DAILY LIST", title: group.feed.title, image: #imageLiteral(resourceName: "close_button"), summary: "", backgroundColor: .white, apps: group.feed.results, cellType: .multipleApp)
                self.items.append(newItem)
            }
            self.items.append(TodayItem.init(category: "HOLIDAYS", title: "PERFECT DESTINATION", image: #imageLiteral(resourceName: "holiday"), summary: "Find out all about how you need to travel without packing", backgroundColor: #colorLiteral(red: 0.9862952828, green: 0.9632481933, blue: 0.7315776944, alpha: 1), apps: nil, cellType: .singleApp))
            self.spinner.stopAnimating()
            self.collectionView.reloadData()
            
            if let group = gamesGroup {
                let newItem = TodayItem.init(category: "DAILY LIST", title: group.feed.title, image: #imageLiteral(resourceName: "close_button"), summary: "", backgroundColor: .white, apps: group.feed.results, cellType: .multipleApp)
                self.items.append(newItem)
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = items[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        
        return cell
    }
    
    @objc fileprivate func handleMultipleAppsTap(sender: UIGestureRecognizer) {
        
        let collectionView = sender.view
        
        // figure out which cell we are clicking into
        var superview = collectionView?.superview
        while superview != nil {
            if let cell = superview as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
                let apps = self.items[indexPath.row].apps
                
                let fullScreenController = TodayMultipleAppsController(mode: .fullScreen)
                fullScreenController.apps = apps ?? []
                present(BackEnabledNavigationController(rootViewController: fullScreenController), animated: true)
            }
            superview = superview?.superview
        }

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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch items[indexPath.item].cellType {
        case .multipleApp:
            showFetchedAppListFullScreen(indexPath)
        default:
            showSingleAppFullScreen(indexPath)
        }
    }
    
    fileprivate func showFetchedAppListFullScreen(_ indexPath: IndexPath) {
        let fullViewController = TodayMultipleAppsController(mode: .fullScreen)
        fullViewController.apps = items[indexPath.item].apps ?? []
        present(BackEnabledNavigationController(rootViewController: fullViewController), animated: true, completion: nil)
    }
    
    var appFullScreenBeginOffset: CGFloat = 0
    
    fileprivate func setupSingleFullScreenController(_ indexPath: IndexPath) {
        let todayAppController = TodayDetailAppController()
        todayAppController.dismissHandler = {
            self.handleAppFullScreenDismissal()
        }
        
        todayAppController.view.layer.cornerRadius = 15
        todayAppController.todayItem = items[indexPath.row]
        self.todayAppController = todayAppController
        blurVisualEffectView.alpha = 1
        
        // setup pan gesture to dismiss controller
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        todayAppController.view.addGestureRecognizer(gesture)
        gesture.delegate = self
        
        // pan gesture should not interfere with scrolling in the tableView
        
    }
    
    @objc fileprivate func handleDrag(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            appFullScreenBeginOffset = todayAppController.tableView.contentOffset.y
        }
        
        // Do not use the gesture if the tableView's content is scrolled down
        if todayAppController.tableView.contentOffset.y > 0 { return }
        
        let translationY = gesture.translation(in: todayAppController.view).y
        
        if translationY > 0 {
            if gesture.state == .changed {
                let actualOffset = translationY - appFullScreenBeginOffset
                
                let scale = min(1, max(0.5, 1 - actualOffset / 1000))
                let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
                
                todayAppController.view.transform = transform
            } else if gesture.state == .ended {
                handleAppFullScreenDismissal()
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    var anchoredConstraints: AnchoredConstraints?
    
    fileprivate func setupAppFullScreenStartingPosition(_ indexPath: IndexPath) {
        view.addSubview(todayAppController.view)
        addChild(todayAppController)
        collectionView.isUserInteractionEnabled = false
        
        setupStartingCellFrame(indexPath)
        
        guard let startingFrame = self.startingFrame else { return }
        
        self.anchoredConstraints = todayAppController.view.anchor(
            top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,
            padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0),
            size: .init(width: startingFrame.width, height: startingFrame.height))
        
        view.layoutIfNeeded()
    }
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let currentCell = collectionView.cellForItem(at: indexPath) else { return }
        // we actually need the cell's absolute coordinates
        guard let startingFrame = currentCell.superview?.convert(currentCell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
    }
    
    fileprivate func beginAnimationOfAppFullScreen() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cell = self.todayAppController.tableView.cellForRow(at: [0,0]) as? TodayAppHeaderCell else {
                return
            }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    fileprivate func showSingleAppFullScreen(_ indexPath: IndexPath) {
        setupSingleFullScreenController(indexPath)
        setupAppFullScreenStartingPosition(indexPath)
        beginAnimationOfAppFullScreen()
    }
    
    var startingFrame: CGRect?
    
    @objc fileprivate func handleAppFullScreenDismissal() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.blurVisualEffectView.alpha = 0
            self.todayAppController.view.transform = .identity
            
            self.todayAppController.tableView.contentOffset = .zero
            
            guard let startingFrame = self.startingFrame else { return }
            
            self.anchoredConstraints?.top?.constant = startingFrame.origin.y
            self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
            self.anchoredConstraints?.width?.constant = startingFrame.width
            self.anchoredConstraints?.height?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = .identity
            
            guard let cell = self.todayAppController.tableView.cellForRow(at: [0,0]) as? TodayAppHeaderCell else {
                return
            }
            self.todayAppController.closeButton.alpha = 0
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
        }, completion: { _ in
            self.todayAppController.removeFromParent()
            self.todayAppController.view.removeFromSuperview()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
}
