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
}
