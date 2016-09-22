//
//  SearchViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/22.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
    
    fileprivate func queryUserName(on key: String) {
        let ref: FIRDatabaseReference = FIRDatabase.database().reference().child("user")
        ref.queryOrdered(byChild: "username").queryEqual(toValue: key).observeSingleEvent(of: .value, with: { (snapShot) in
            print(snapShot)
        }) { (error) in
            print(error)
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text: String = searchController.searchBar.text else { return }
        self.queryUserName(on: text)
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
