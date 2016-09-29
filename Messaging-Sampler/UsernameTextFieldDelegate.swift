//
//  UsernameTextFieldDelegate.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/29.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Rainbow
import Firebase

enum UsernameResultType {
    case none
    case exist
}



class UsernameTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let notificationCenter: NotificationCenter = NotificationCenter.default
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.validateUsername(equalTo: textField.text)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func validateUsername(equalTo string: String?) {
        self.notificationCenter.post(name: .usernameNotificationKey, object: nil)
//        let ref = FIRDatabase.database().reference()
//        ref.child("user").queryOrdered(byChild: "username").queryEqual(toValue: string).observeSingleEvent(of: .value, with: { (snapshot) in
//            if snapshot.hasChildren() {
//                usernameResultType = .exist
//
//            }else {
//                usernameResultType = .none
//            }
//        }) { (error) in
//            print(error)
//        }
    }
}

extension Notification.Name {
    static let usernameNotificationKey = Notification.Name("usernameNotification")
}
