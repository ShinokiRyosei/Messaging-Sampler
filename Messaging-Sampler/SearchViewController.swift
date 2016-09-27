//
//  SearchViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/22.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {
    
    fileprivate var searchController: UISearchController!
    
    @IBOutlet var table: UITableView!
    
    var searches: [Search] = []
    
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
    
    func queryUserName(on key: String) {
        let ref: FIRDatabaseReference = FIRDatabase.database().reference().child("user")
        ref.queryOrdered(byChild: "username").queryEqual(toValue: "\(key)\u{f8ff}").observeSingleEvent(of: .value, with: { (snapShot) in
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
    
    func createRoom(search: Search)  {
        let ref = FIRDatabase.database().reference().child("room")
        let defaults = UserDefaults.standard
        let uid = defaults.object(forKey: "uid") as! String
        ref.queryOrdered(byChild: uid).queryEqual(toValue: true).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                print("snapshot exits")
            }else {
                ref.childByAutoId().setValue(["title": "Talk", "messages": [uid: true, search.id: true]])
            }
            }) { (err) in
                print(err)
        }
//        ref.child("room").childByAutoId().setValue(["user1": search.id, "user2": defaults.object(forKey: "uid") as! String])
        // TODO トークルームが存在するかの確認
        // TODO トークルームを作成した段階で、トークルームへの遷移
    }
}

