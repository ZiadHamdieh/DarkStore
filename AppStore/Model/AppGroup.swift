//
//  AppGroup.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-18.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {

    let feed: Feed
    
}

struct Feed: Decodable {
    
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    
    let name, artistName, artworkUrl100: String
    
}
