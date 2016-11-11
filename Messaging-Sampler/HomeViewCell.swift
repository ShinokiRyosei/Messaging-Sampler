//
//  HomeViewCell.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    internal var room: Room! {
        
        didSet {
            
            
        }
    }
    
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var usernameLabel: UILabel!

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
}
