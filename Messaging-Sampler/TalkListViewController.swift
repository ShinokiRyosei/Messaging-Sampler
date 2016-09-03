//
//  TalkListViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class TalkListViewController: UIViewController {
    
    @IBOutlet var talkListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        talkListTableView.delegate = self
        talkListTableView.dataSource = self
        
        talkListTableView.registerNib(UINib(nibName: "TalkListViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "TalkListCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
