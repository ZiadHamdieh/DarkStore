//
//  Service.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-15.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApps(fromSearchQuery query: String, completion: @escaping (AppSearchResults?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(query)&entity=software"
        fetchJSON(fromUrlString: urlString, completion: completion)
    }
    
    func fetchHeaderApps(completion: @escaping ([HeaderResult]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchJSON(fromUrlString: urlString, completion: completion)
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchJSON(fromUrlString: "https://rss.itunes.apple.com/api/v1/ca/ios-apps/new-games-we-love/all/25/explicit.json", completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchJSON(fromUrlString: "https://rss.itunes.apple.com/api/v1/ca/ios-apps/top-grossing/all/25/explicit.json", completion: completion)
    }
    
    func fetchTopFreeIPhoneApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchJSON(fromUrlString: "https://rss.itunes.apple.com/api/v1/ca/ios-apps/top-free/all/25/explicit.json", completion: completion)
    }
    
    func fetchTopPaidIPhoneApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchJSON(fromUrlString: "https://rss.itunes.apple.com/api/v1/ca/ios-apps/top-paid/all/25/explicit.json", completion: completion)
    }
    
    // Helper function
    func fetchJSON<T: Decodable>(fromUrlString urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error  {
                completion(nil, error )
                return
            }
            
            guard let data = data else { return }
            
            do {
                let appGroup = try JSONDecoder().decode(T.self, from: data)
                completion(appGroup, nil)
            } catch let jsonErr {
                completion(nil, jsonErr)
            }
            }.resume()
    }

}
