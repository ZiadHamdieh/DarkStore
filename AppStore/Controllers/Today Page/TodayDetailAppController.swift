//
//  TodayDetailAppController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-21.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TodayDetailAppController: UITableViewController {
    
    let cellId = "cellId"
    
    var todayItem: TodayItem?
    
    var dismissHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
        tableView.register(TodayAppDescriptionCell.self, forCellReuseIdentifier: cellId)
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = TodayAppHeaderCell()
            headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            headerCell.todayCell.todayItem = todayItem
            return headerCell
        }
        //TODO Fix this
        return (indexPath.row == 0) ? TodayAppHeaderCell(): TodayAppDescriptionCell()
    }
    
    @objc fileprivate func handleDismiss(sender: UIButton) {
        sender.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 400
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}