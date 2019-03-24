//
//  TodayDetailAppController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-21.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TodayDetailAppController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "cellId"
    
    var todayItem: TodayItem?
    
    var dismissHandler: (() -> ())?
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        setupCloseButton()
        setupFloatingControl()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .white
        tableView.register(TodayAppDescriptionCell.self, forCellReuseIdentifier: cellId)
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: statusBarHeight, right: 0)
    }
    
    fileprivate func setupFloatingControl() {
        let containerView = UIView()
    
        view.addSubview(containerView)
        let bottomPadding = UIApplication.shared.statusBarFrame.height
        containerView.anchor(
            top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: bottomPadding, right: 16),
            size: .init(width: view.frame.width, height: 80))
        containerView.layer.cornerRadius = 15
        
        let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        containerView.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        containerView.clipsToBounds = true
        
        
        let titleLabel = UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18))
        let subtitleLabel = UILabel(text: "Using your time", font: .systemFont(ofSize: 18))
        let getButton = UIButton(title: "GET", cornerRadius: 15)
        getButton.setTitleColor(.white, for: .normal)
        getButton.backgroundColor = .darkGray
        getButton.constrainWidth(constant: 60)
        
        
        let imageView: UIImageView = {
            let iv = UIImageView(cornerRadius: 12)
            iv.constrainWidth(constant: 60)
            iv.constrainHeight(constant: 60)
            iv.image = todayItem?.image
            return iv
            
        }()
        
        let stackView = UIStackView(arrangedSubViews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                titleLabel,
                subtitleLabel
                ], spacing: 4),
            UIView(),
            getButton
            ], spacing: 16)
        containerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
    }
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor,
            padding: .init(top: 12, left: 0, bottom: 0, right: 0),
            size: .init(width: 80, height: 40))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = TodayAppHeaderCell()
            headerCell.todayCell.todayItem = todayItem
            headerCell.todayCell.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            headerCell.todayCell.backgroundView = nil
            return headerCell
        }
        //TODO Fix this
        return (indexPath.row == 0) ? TodayAppHeaderCell(): TodayAppDescriptionCell()
    }
    
    @objc fileprivate func handleDismiss(sender: UIButton) {
        sender.isHidden = true
        dismissHandler?()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayPageController.cellHeight
        }
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            // disable scrolling temporarily and re-enable it immediately
            scrollView.isScrollEnabled.toggle()
            scrollView.isScrollEnabled.toggle()
        }
    }
    
}
