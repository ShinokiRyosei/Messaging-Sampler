//
//  SignupViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/01.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var passwordAgainTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
        
        passwordTextField.secureTextEntry = true
        passwordAgainTextField.secureTextEntry = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if FIRAuth.auth()?.currentUser != nil {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSelectSignup() {
        AuthUtility.signupWithEmail(email: emailTextField.text, password: passwordTextField.text, passwordAgain: passwordAgainTextField.text) { 
            // MARK: code after signed up
            self.toLoginViewTransition()
        }
    }
    
    @IBAction func didSelectToLogin() {
        self.toLoginViewTransition()
    }
    
    func toLoginViewTransition()  {
        self.performSegueWithIdentifier("toLoginView", sender: nil)
    }
    
    func toHomeViewTransition() {
        
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}