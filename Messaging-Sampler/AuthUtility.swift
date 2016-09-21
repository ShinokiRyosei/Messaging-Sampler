//
//  AuthUtility.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/03.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AuthUtility: NSObject {
    
    class func signupWithEmail(email emailText: String?, password passwordText: String?, passwordAgain passwordAgainText: String?, username: String?,handler: @escaping  () -> Void) {
        guard let email: String = emailText else { return }
        guard let password: String = passwordText else { return }
        guard let passwordAgain: String = passwordAgainText else { return }
        guard let name: String = username else { return }
        if password == passwordAgain {
            FIRAuth.auth()!.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print("create user error...\(error?.localizedDescription)")
                }else {
                    user?.sendEmailVerification(completion: { (err) in
                        if err != nil {
                            print("email verify error...\(err?.localizedDescription)")
                        }else {
                            let defaults: UserDefaults = UserDefaults.standard
                            defaults.set((FIRAuth.auth()?.currentUser?.uid)!, forKey: "uid")
                            FIRDatabase.database().reference().child("user").child((FIRAuth.auth()?.currentUser?.uid)!).setValue(["username": name, "id": (FIRAuth.auth()?.currentUser?.uid)!])
                            handler()
                        }
                    })
                    
                }
            })
        }
    }
    
    // Log in
    class func loginWithEmail(_ target: UIViewController, email emailText: String?, password passwordText: String?, handler: @escaping () -> Void) {
        guard let email: String = emailText else { return }
        guard let password: String = passwordText else { return }
        FIRAuth.auth()!.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if user?.isEmailVerified == true {
                    handler()
                }else {
                    Utility.presentAlert(on: target, title: "Email is not Verified", message: "Please Verify your email.", numberOfActions: 1, actionTitles: ["OK"], actionStyles: [.default], actionHandlers: [nil])
                }
                
            }
        })
    }
}
