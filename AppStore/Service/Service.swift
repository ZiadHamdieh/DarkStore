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
    
    func fetchApps(fromSearchQuery query: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(query)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch results: ", err)
                completion([], err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(AppSearchResults.self, from: data)
                completion(searchResult.results, nil)
            } catch let jsonDecodeError {
                print("Failed to decode JSON: ", jsonDecodeError)
                completion([], jsonDecodeError)
            }
            }.resume()
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/ca/ios-apps/new-games-we-love/all/25/explicit.json", completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/ca/ios-apps/top-grossing/all/25/explicit.json", completion: completion)
    }
    
    func fetchTopFreeIPhoneApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/ca/ios-apps/top-free/all/25/explicit.json", completion: completion)
    }
    
    func fetchTopPaidIPhoneApps(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/ca/ios-apps/top-paid/all/25/explicit.json", completion: completion)
    }
    
    // Helper function
    fileprivate func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error  {
                completion(nil, error )
                return
            }
            
            guard let data = data else { return }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
                completion(appGroup, nil)
            } catch let jsonErr {
                completion(nil, jsonErr)
            }
            }.resume()
    }
    
    func fetchHeaderApps(completion: @escaping ([HeaderResult]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let HeaderGroup = try JSONDecoder().decode([HeaderResult].self, from: data)
                completion(HeaderGroup, nil)
            } catch let jsonErr {
                completion(nil, jsonErr)
            }
        }.resume()
    }
}
