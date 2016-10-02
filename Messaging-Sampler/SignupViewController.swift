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



class SignupViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordAgainTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var usernameNotificationLabel: UILabel!
    
    fileprivate let segueName: String = "toLoginView"
    
    private var delegate: UsernameTextFieldDelegate!
    
    private let notificationCenter: NotificationCenter = NotificationCenter.default
    
    var usernameResultType: UsernameResultType = .exist
    
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
    
    func changeUsernameLabel(notification: Notification) {
        print("catch notification".red)
        print(notification.userInfo?["usernameResultType"])
        usernameResultType = notification.userInfo?["usernameResultType"] as? UsernameResultType ?? .exist
        usernameNotificationLabel.text = {
            if usernameResultType == .exist {
                return "This username has already been registered"
            }else if usernameResultType == .none {
                return "This username can be used"
            }else {
                return ""
            }
        }()
    }
    
    @IBAction func didSelectSignup() {
        if !usernameResultType.usernameExistsOrNot() {
            print("signed up!!!".green)
            let defaults: UserDefaults = UserDefaults.standard
            AuthUtility.signupWithEmail(email: emailTextField.text, password: passwordTextField.text, passwordAgain: passwordAgainTextField.text, username: usernameTextField.text, successHandler: {
                print("sign up successful!!".onCyan)
                defaults.set(self.usernameTextField.text, forKey: "username")
                Utility.segueTransition(from: self, segue: self.segueName, sender: nil)
            })
            
        }else if usernameResultType.usernameExistsOrNot() {
            // error handler: user name is not unique
            print("sign up failed!!".onGreen)
            let usernameError: ((UIAlertAction) -> Void) = { _ in
                self.usernameTextField.text = ""
            }
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
