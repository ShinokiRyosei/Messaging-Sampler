//
//  HomeViewCell.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var usernameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
