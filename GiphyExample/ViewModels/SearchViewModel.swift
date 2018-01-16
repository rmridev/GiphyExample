//
//  SearchViewModel.swift
//  GiphyExample
//
//  Created by Daniel Langh on 2018. 01. 16..
//  Copyright © 2018. rumori. All rights reserved.
//

import UIKit

class SearchViewModel: SearchViewModelType {

    private let client: GiphyClient
    private var request: Cancelable?
    
    // MARK: -
    
    private var items: [GifCellViewModelType] = []
    var updateHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    // MARK: -
    
    deinit {
        request?.cancel()
    }
    
    init(client: GiphyClient) {
        self.client = client
    }
    
    // MARK: -
    
    func load() {
        search(nil)
    }
    
    func search(_ query: String?) {

        self.request?.cancel()
        self.request = nil
        
        if let query = query {
            request = client.search(query, completion: { [weak self] results in
                self?.handleResults(results)
            }, failure: { [weak self] error in
                self?.handleError(error)
            })
        } else {
            request = client.getTrending(completion: { [weak self] (results) in
                self?.handleResults(results)
            }, failure: { [weak self] error in
                self?.handleError(error)
            })
        }
    }
    
    // MARK: -
    
    private func handleResults(_ results: GiphyResults) {
        self.items = results.data.map { GifCellViewModel($0) }
        updateHandler?()
    }
    
    private func handleError(_ error: Error) {
        self.items = []
        errorHandler?(error)
    }
    
    // MARK: - SearchViewModelType protocol
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func itemAt(_ index: Int) -> GifCellViewModelType {
        return items[index]
    }
    
}
