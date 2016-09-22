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
    
    fileprivate var searches: [Search] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTable()
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
            print("snapShot...\(snapShot)")
            self.loadSearchResults(snapshot: snapShot)
        }) { (error) in
            print(error)
        }
    }
    
    private func loadSearchResults(snapshot: FIRDataSnapshot) {
        defer {
            self.table.reloadData()
        }
        if let children: [FIRDataSnapshot] = snapshot.children.allObjects as? [FIRDataSnapshot] {
            self.searches.removeAll()
            for child in children {
                print(child)
                let search: Search = Search(snapshot: child)
                self.searches.append(search)
            }
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
        return searches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchViewCell
        cell.nameLabel.text = searches[indexPath.row].username
        return cell
    }
}
