//
//  TodayMultipleAppsController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-22.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController {
    
    fileprivate let cellId = "cellId"
    
    override var prefersStatusBarHidden: Bool { return true }
    
    var results = [FeedResult]()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    fileprivate let cellSpacing: CGFloat = 16
    
    fileprivate let mode: Mode

    enum Mode {
        case small
        case fullScreen
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.isScrollEnabled = (mode == .fullScreen)
        collectionView.backgroundColor = .white
        
        if mode == .fullScreen {
            setupCloseButton()
        }
        
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(
            top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 16),
            size: .init(width: 44, height: 44))
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mode == .fullScreen) ? results.count : min(results.count, 4)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
        // triggers the property observer in MultipleAppCell.swift
        cell.app = results[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appId = results[indexPath.item].id
        let appController = AppDetailController(appId: appId)
//        navigationController?.pushViewController(appController, animated: true)
        present(appController, animated: true, completion: nil)
        print("click")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = 74
        let fullScreenWidth = view.frame.width - 48
        let smallWidth = view.frame.width
        
        return (mode == .fullScreen) ?
            .init(width: fullScreenWidth, height: height) :
            .init(width: smallWidth, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return (mode == .fullScreen) ? .init(top: 12, left: 24, bottom: 12, right: 24) : .zero
    }
    
}
