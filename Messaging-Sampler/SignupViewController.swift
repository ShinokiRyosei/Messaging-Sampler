//
//  SignupViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/01.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignupViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var passwordAgainTextField: UITextField!
    
    @IBOutlet var usernameTextField: UITextField!
    
    fileprivate let segueName: String = "toLoginView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
        usernameTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
        passwordAgainTextField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if FIRAuth.auth()?.currentUser != nil && FIRAuth.auth()?.currentUser?.isEmailVerified == true {
            print("user is already logged in")
            Transition().toHomeViewTransition(on: self)
        }
    }
    
    @IBAction func didSelectSignup() {
        let usernameError: ((UIAlertAction) -> Void) = { _ in
            self.usernameTextField.text = ""
        }
        AuthUtility.signupWithEmail(email: emailTextField.text, password: passwordTextField.text, passwordAgain: passwordAgainTextField.text, username: usernameTextField.text, successHandler: {
            print("sign up successful!!")
            Utility.segueTransition(from: self, segue: self.segueName, sender: nil)
        }) {
            // error handler: user name is not unique
            print("sign up failed!!")
            Utility.presentAlert(on: self, title: "User name has already been used", message: "User name must be unique", numberOfActions: 1, actionTitles: ["OK"], actionStyles: [.default], actionHandlers: [usernameError])
        }
    }
    
    @IBAction func didSelectToLogin() {
        Utility.segueTransition(from: self, segue: segueName, sender: nil)
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
