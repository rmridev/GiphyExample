//
//  GiphyClient.swift
//  GiphyExample
//
//  Created by Daniel Langh on 2018. 01. 16..
//  Copyright © 2018. rumori. All rights reserved.
//

import UIKit
import Alamofire
import Argo

class GiphyClient {
    
    let apiKey: String = "NA45aP4ExnxclSXPREcspi5CYcOchCRC"
    
    func getTrending(completion: @escaping (GiphyResults) -> Void, failure: ((Error) -> Void)? = nil) {
        let url = "https://api.giphy.com/v1/gifs/trending"
        let parameters: [String: Any] = [
            "api_key": apiKey,
            "offset": 0,
            "limit": 25,
            "lang": "en",
            "rating": "G"
        ]
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let results = GiphyResults.decode(json)
                switch results {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    failure?(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func search(_ query: String, completion: @escaping (GiphyResults) -> Void, failure: ((Error) -> Void)? = nil) {
        
        let url = "https://api.giphy.com/v1/gifs/search"
        let parameters: [String: Any] = [
            "api_key": apiKey,
            "q": query,
            "offset": 0,
            "limit": 25,
            "lang": "en",
            "rating": "G"
        ]
        Alamofire.request(url, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let results = GiphyResults.decode(json)
                switch results {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    failure?(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
