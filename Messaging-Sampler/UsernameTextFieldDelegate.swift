//
//  UsernameTextFieldDelegate.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/29.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Firebase

enum UsernameResultType {
    case none
    case exist
    
    func usernameExistsOrNot() -> Bool {
        switch self {
        case .exist:
            return true
        case .none:
            return false
        }
    }
}

class UsernameTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let notificationCenter: NotificationCenter = NotificationCenter.default
    
    var usernameResultType: UsernameResultType = .none
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.validateUsername(equalTo: textField.text)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func validateUsername(equalTo string: String?) {
        
        
        let ref = FIRDatabase.database().reference()
        ref.child("user").queryOrdered(byChild: "username").queryEqual(toValue: string).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChildren() {
                self.usernameResultType = .exist
                self.notificationCenter.post(name: .usernameNotificationKey, object: nil, userInfo: ["usernameResultType": self.usernameResultType])
                
            }else {
                self.usernameResultType = .none
                self.notificationCenter.post(name: .usernameNotificationKey, object: nil, userInfo: ["usernameResultType": self.usernameResultType])
            }
        }) { (error) in
            print(error)
        }
    }
}

extension Notification.Name {
    static let usernameNotificationKey = Notification.Name("usernameNotification")
}
