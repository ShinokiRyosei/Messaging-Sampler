//
//  HomeViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    @IBOutlet var homeTable: UITableView!
    
    let ref: FIRDatabaseReference = FIRDatabase.database().reference()
    
    let defaults: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        homeTable.delegate = self
        homeTable.dataSource = self
        
        homeTable.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
