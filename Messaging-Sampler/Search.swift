//
//  Search.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/23.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import Foundation
import Firebase

struct Search {
    var id: String
    var username: String
    
    init(id: String, username: String) {
        self.id = id
        self.username = username
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        if let item: [String : String] = snapshot.value as? [String: String] {
            id = snapshot.key
            username = item["username"]!
            print(self)
        }else {
            id = ""
            username = ""
        }
    }
}
