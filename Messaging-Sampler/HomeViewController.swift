//
//  HomeViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Firebase
import JEToolkit

class HomeViewController: UIViewController {
    
    @IBOutlet var homeTable: UITableView! {
        
        didSet {
            
            homeTable.delegate = self
            homeTable.dataSource = self
            homeTable.registerCellClass(HomeViewCell.self)
        }
    }
    
    let ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    let defaults: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    func fetchRoomList() {
        let username: String = defaults.object(forKey: "username") as! String
        ref.child("rooms").queryOrdered(byChild: username).queryEqual(toValue: true).observe(.value, with: { (snapshot) in
            if snapshot.hasChildren() {
                
            }
            }) { (err) in
                print(err)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: HomeViewCell = tableView.dequeueReusableCell(with: HomeViewCell.self, for: indexPath) as? HomeViewCell else {
            
            return UITableViewCell()
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Utility.segueTransition(from: self, segue: "toMessageView", sender: nil)
    }
}
