//
//  SettingViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/24.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didSelectLogout(sender: UIButton) {
        do {
            try FIRAuth.auth()?.signOut()
            let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as! UINavigationController
            self.present(loginView, animated: true, completion: nil)
        }catch let error as FIRAuthErrorCode {
            print(error)
        }catch let err {
            print(err)
        }
    }
}
