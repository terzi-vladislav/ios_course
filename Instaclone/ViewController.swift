//
//  ViewController.swift
//  Instagram
//
//  Created by Vladislav Terzi on 26/02/2020.
//  Copyright © 2020 Vladislav Terzi. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.imageError(UIImage(named: "x"))
        ProgressHUD.imageSuccess(UIImage(named: "check"))
        ProgressHUD.colorHUD(UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3))
        
        self.hideKeyboardWhenTappedAround()
        loginButton.layer.cornerRadius = 0.5 * loginButton.bounds.size.height
        emailTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        emailTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        passwordTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        
        handleTextField()
        
        loginButton.isEnabled = false
        loginButton.addTarget(self, action: #selector(self.loginBttn_TouchUpInside), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            let storyBoard = UIStoryboard(name: "TabBarController", bundle: nil)
            let signInVC = storyBoard.instantiateViewController(identifier: "TabBar")
            signInVC.modalPresentationStyle = .fullScreen
            self.present(signInVC, animated: true, completion: nil)
        }
    }
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            errorText.text = "enter data"
            self.loginButton.isEnabled = false
            loginButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            loginButton.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
            return
        }
        
        if let password = passwordTextField.text, password.count < 6 {
            self.loginButton.isEnabled = false
            loginButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            loginButton.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
            errorText.text = "enter data"
            return
        }
        self.errorText.text = nil
        self.loginButton.isEnabled = true
        self.loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.loginButton.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
    }
    
    @IBAction func loginBttn_TouchUpInside(_ sender: Any) {
        ProgressHUD.show("Loggin in", interaction: false)
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if error != nil {
                self.errorText.text = "no such user"
                print(error!.localizedDescription)
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Successful")
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                let storyBoard = UIStoryboard(name: "TabBarController", bundle: nil)
                let signInVC = storyBoard.instantiateViewController(identifier: "TabBar")
                signInVC.modalPresentationStyle = .fullScreen
                self.present(signInVC, animated: true, completion: nil)
            }
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

