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
        guard let email: String = emailTextField.text else { return }
        guard let password: String = passwordTextField.text else { return }
        guard let passwordAgain: String = passwordAgainTextField.text else { return }
        if password == passwordAgain {
            FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
                if error != nil {
                    print(error?.localizedDescription)
                }else {
                    
                }
            })
        }
    }
    
    @IBAction func didSelectToLogin() {
        
    }
    
    func toLoginViewTransition()  {
        self.performSegueWithIdentifier("", sender: nil)
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