//
//  AppResult.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-15.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import Foundation

struct AppSearchResults: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl512: String   // app Icon
}
