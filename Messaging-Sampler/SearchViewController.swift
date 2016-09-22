//
//  SearchViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/22.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    fileprivate var searchController: UISearchController!
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchController()
    }
    
    private func configureTable() {
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "SearchViewCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        table.tableFooterView = UIView()
    }
    
    private func configureSearchController() {
        searchController = {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.searchBarStyle = .prominent
            searchController.searchBar.sizeToFit()
            table.tableHeaderView = searchController.searchBar
            return searchController
        }()
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchViewCell
        return cell
    }
}
