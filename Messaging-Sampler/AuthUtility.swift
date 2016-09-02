//
//  AuthUtility.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthUtility: NSObject {
    
    class func signupWithEmail(email emailText: String?, password passwordText: String?, passwordAgain passwordAgainText: String?, handler: () -> Void) {
        guard let email: String = emailText else { return }
        guard let password: String = passwordText else { return }
        guard let passwordAgain: String = passwordAgainText else { return }
        if password == passwordAgain {
            FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
                if error != nil {
                    print(error?.localizedDescription)
                }else {
                    handler()
                }
            })
        }
    }
    
    // Log in
    class func loginWithEmail(email emailText: String?, password passwordText: String?, handler: () -> Void) {
        guard let email: String = emailText else { return }
        guard let password: String = passwordText else { return }
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                handler()
            }
        })
    }
}
