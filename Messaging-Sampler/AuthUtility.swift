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
                    print("create user error...\(error?.localizedDescription)")
                }else {
                    user?.sendEmailVerificationWithCompletion({ (err) in
                        if err != nil {
                            print("email verify error...\(err?.localizedDescription)")
                        }else {
                            handler()
                        }
                    })
                    
                }
            })
        }
    }
    
    // Log in
    class func loginWithEmail(target: UIViewController, email emailText: String?, password passwordText: String?, handler: () -> Void) {
        guard let email: String = emailText else { return }
        guard let password: String = passwordText else { return }
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if user?.emailVerified == true {
                    handler()
                }else {
                    Utility.presentAlert(on: target, title: "Email is not Verified", message: "Please Verify your email.", numberOfActions: 1, actionTitles: ["OK"], actionStyles: [.Default], actionHandlers: [nil])
                }
                
            }
        })
    }
}
