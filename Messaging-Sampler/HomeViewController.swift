//
//  HomeViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet var homeTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        homeTable.delegate = self
        homeTable.dataSource = self
        
        homeTable.registerNib(UINib(nibName: "HomeViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchUserList() {
        
    }
}
