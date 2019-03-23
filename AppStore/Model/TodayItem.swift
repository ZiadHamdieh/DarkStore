//
//  TodayItem.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-22.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let summary: String
    let backgroundColor: UIColor
    
    let cellType: cellType
    
    enum cellType: String {
        case singleApp
        case multipleApp
    }
}
