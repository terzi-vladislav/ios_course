//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Vladislav Terzi on 26/02/2020.
//  Copyright © 2020 Vladislav Terzi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var warningText: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBttn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        profileImage.layer.cornerRadius = 0.5 * profileImage.bounds.size.height
        signUpButton.layer.cornerRadius = 0.5 * signUpButton.bounds.size.height
        
        nameTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        emailTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        passwordTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectProfileImage))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        
        handleTextField()
        
        self.signUpBttn.isEnabled = false
        signUpBttn.addTarget(self, action: #selector(self.signUpBttn_TouchUpInside), for: .touchUpInside)
    }
    
    func handleTextField() {
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let username = nameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signUpBttn.isEnabled = false
            signUpBttn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            signUpBttn.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
            warningText.text = "Please enter the data"
            return
        }
        if let email = emailTextField.text, !email.contains("@") {
            self.signUpBttn.isEnabled = false
            self.signUpBttn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.signUpBttn.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
            warningText.text = "wrong email format"
            return
        }
        if let email = emailTextField.text, !email.contains(".") {
            self.signUpBttn.isEnabled = false
            self.signUpBttn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.signUpBttn.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
            warningText.text = "wrong email format"
            return
        }
        if let password = passwordTextField.text, password.count < 6 {
            self.signUpBttn.isEnabled = false
            self.signUpBttn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            self.signUpBttn.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
            warningText.text = "enter at least 6 characters"
            return
        }
        
        self.warningText.text = nil
        self.signUpBttn.isEnabled = true
        self.signUpBttn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.signUpBttn.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
    }
    
    @IBAction func signUpBttn_TouchUpInside(_ sender: Any) {
        ProgressHUD.show("Progress")
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            if error != nil {
                ProgressHUD.showError("Error")
                self.signUpBttn.isEnabled = false
                return
            }
            
            let uid = Auth.auth().currentUser?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_REF).child("profile_image").child(uid!)

            if let profileIMG = self.selectedImage, let imageData = profileIMG.jpegData(compressionQuality: 0.5) {
                storageRef.putData(imageData, metadata: nil) { (metadata, error) in

                    if error != nil {
                        self.signUpBttn.isEnabled = false
                        return
                    }

                    storageRef.downloadURL(completion: { (url, error) in

                        if error != nil {
                            self.signUpBttn.isEnabled = false
                            return
                        }

                        self.setUserInfoWithImage(profileImageURL: url!.absoluteString, username: self.nameTextField.text!, email: self.emailTextField.text!, uid: uid!)
                    })
                }
            }
            self.setUserInfoWithoutImage(username: self.nameTextField.text!, email: self.emailTextField.text!, uid: uid!)
            ProgressHUD.showSuccess("Success")
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                let storyBoard = UIStoryboard(name: "TabBarController", bundle: nil)
                let signInVC = storyBoard.instantiateViewController(identifier: "TabBar")
                signInVC.modalPresentationStyle = .fullScreen
                self.present(signInVC, animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleSelectProfileImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUserInfoWithImage (profileImageURL: String, username: String, email: String, uid: String) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": username, "email": email, "profile_image_url": profileImageURL])
    }

    func setUserInfoWithoutImage (username: String, email: String, uid: String) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": username, "email": email])
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            selectedImage = image
            profileImage.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
