//
//  ViewController.swift
//  Instagram
//
//  Created by Vladislav Terzi on 26/02/2020.
//  Copyright © 2020 Vladislav Terzi. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        loginButton.layer.cornerRadius = 0.5 * loginButton.bounds.size.height
        emailTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        emailTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        passwordTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        
        handleTextField()
        
        loginButton.isEnabled = false
        loginButton.addTarget(self, action: #selector(SignUpViewController.tapped), for: .touchUpInside)
    }
    
    @objc func tapped(sender: UIButton!) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            emailTextField.placeholder = "enter email"
            passwordTextField.placeholder = "enter password"
            return
        }
    }
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            loginButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            loginButton.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
            return
        }
        
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
    }
    
    @IBAction func loginBttn_TouchUpInside(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self.performSegue(withIdentifier: "SignInToTabBar", sender: nil)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

