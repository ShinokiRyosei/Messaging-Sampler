//
//  SearchViewCell.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/22.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class SearchViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    
    var tabAction: ((UITableViewCell) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didSelectAdd(sender: UIButton) {
        tabAction?(self)
    }
}
