//
//  SignupViewController.swift
//  Messaging-Sampler
//
//  Created by ShinokiRyosei on 2016/09/01.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import Firebase
import Rainbow

var usernameResultType: UsernameResultType = .exist

class SignupViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var passwordAgainTextField: UITextField!
    
    @IBOutlet var usernameTextField: UITextField!
    
    fileprivate let segueName: String = "toLoginView"
    
    private var delegate: UsernameTextFieldDelegate!
    
    private let notificationCenter: NotificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
        delegate = UsernameTextFieldDelegate()
        usernameTextField.delegate = delegate
        
        passwordTextField.isSecureTextEntry = true
        passwordAgainTextField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if FIRAuth.auth()?.currentUser != nil && FIRAuth.auth()?.currentUser?.isEmailVerified == true {
            print("user is already logged in")
            Transition().toHomeViewTransition(on: self)
        }
        
        notificationCenter.addObserver(self, selector: #selector(SignupViewController.changeUsernameLabel(notification:)), name: .usernameNotificationKey, object: nil)
    }
    
    func changeUsernameLabel(notification: NotificationCenter) {
        print("catch notification".red)
    }
    
    @IBAction func didSelectSignup() {
        if usernameResultType == .none {
            print("signed up!!!".green)
            AuthUtility.signupWithEmail(email: emailTextField.text, password: passwordTextField.text, passwordAgain: passwordAgainTextField.text, username: usernameTextField.text, successHandler: {
                print("sign up successful!!".onCyan)
                Utility.segueTransition(from: self, segue: self.segueName, sender: nil)
            }) {
                // error handler: user name is not unique
                print("sign up failed!!".onGreen)
                let usernameError: ((UIAlertAction) -> Void) = { _ in
                    self.usernameTextField.text = ""
                }
                Utility.presentAlert(on: self, title: "User name has already been used", message: "User name must be unique", numberOfActions: 1, actionTitles: ["OK"], actionStyles: [.default], actionHandlers: [usernameError])
            }
        }else if usernameResultType == .exist {
            
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
