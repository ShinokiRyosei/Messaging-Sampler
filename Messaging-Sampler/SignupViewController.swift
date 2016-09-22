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

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
        usernameTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
        passwordAgainTextField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if FIRAuth.auth()?.currentUser != nil && FIRAuth.auth()?.currentUser?.isEmailVerified == true {
//            print("user is already logged in")
//            Transition().toHomeViewTransition(on: self)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectSignup() {
        AuthUtility.signupWithEmail(email: emailTextField.text, password: passwordTextField.text, passwordAgain: passwordAgainTextField.text, username: usernameTextField.text) {
            // MARK: the transition to log in view after sign up
            
            Utility.segueTransition(from: self, segue: self.segueName, sender: nil)
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
