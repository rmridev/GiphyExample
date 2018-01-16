//
//  ViewController.swift
//  GiphyExample
//
//  Created by Daniel Langh on 2018. 01. 16..
//  Copyright © 2018. rumori. All rights reserved.
//

import UIKit

protocol SearchViewModelType: class {
    func numberOfItems() -> Int
    func itemAt(_ index: Int) -> GifCellViewModelType

    var updateHandler: (() -> Void)? { get set }
    var errorHandler: ((Error) -> Void)? { get set }
    
    func load()
    func search(_ query: String?)
}

// MARK: -

class ViewController: UITableViewController {
    
    let cellId = "GifCell"

    var viewModel: SearchViewModelType?
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupViewModel()
        setupTableView()
        
        viewModel?.load()
    }
    
    // MARK: -
    
    private func setupSearchBar() {
        let searchbar = UISearchBar()
        searchbar.delegate = self
        searchbar.placeholder = "Search"
        self.navigationItem.titleView = searchbar
    }
    
    private func setupViewModel() {
        let client = GiphyClient()
        let viewModel = SearchViewModel(client: client)
        viewModel.updateHandler = { [weak self] in
            self?.update()
        }
        self.viewModel = viewModel
    }
    
    private func setupTableView() {
        tableView.rowHeight = 210
        tableView.estimatedRowHeight = 210
    }
    
    private func update() {
        tableView.reloadData()
    }
    
    // MARK: -
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GifCell
        if let item = viewModel?.itemAt(indexPath.row) {
            cell.viewModel = item
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text
        viewModel?.search(query)
        searchBar.resignFirstResponder()
    }
}

