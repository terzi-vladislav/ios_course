//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Vladislav Terzi on 26/02/2020.
//  Copyright © 2020 Vladislav Terzi. All rights reserved.
//

import UIKit
//import FirebaseAuth
//import FirebaseDatabase
//import FirebaseStorage

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var warningText: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var signUpBttn: UIButton!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        profileImage.layer.cornerRadius = 0.5 * profileImage.bounds.size.height
        signUpButton.layer.cornerRadius = 0.5 * signUpButton.bounds.size.height
        
        nameTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        emailTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        passwordTextField.tintColor = UIColor(white: 1.0, alpha: 0.6)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImage))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        
        handleTextField()
        
        signUpBttn.isEnabled = false
        signUpBttn.addTarget(self, action: #selector(SignUpViewController.tapped), for: .touchUpInside)
    }
    
     @objc func tapped(sender: UIButton!) {
        guard let username = nameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, password.count > 5 else {
                passwordTextField.text = nil
                warningText.text = "enter at least 6 characters"
            return
        }
    }
    
    func handleTextField() {
        nameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let username = nameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            signUpBttn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            signUpBttn.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
            signUpBttn.isEnabled = false
            warningText.text = "Please enter the data"
            return
        }
        
        warningText.text = nil
        signUpBttn.isEnabled = true
        signUpBttn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signUpBttn.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
    }
    
    @objc func handleSelectProfileImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func signUpBttn_TchUpInside(_ sender: Any) {
//
//        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
//            if error != nil {
//                print("error \(error!.localizedDescription)")
//                return
//            }
//
//            print("hello")
//
//            let uid = Auth.auth().currentUser?.uid
//            let storageRef = Storage.storage().reference(forURL: "gs://instagram-45c6b.appspot.com").child("profile_image").child(uid!)
//
//            if let profileIMG = self.selectedImage, let imageData = profileIMG.jpegData(compressionQuality: 0.5) {
//                storageRef.putData(imageData, metadata: nil) { (metadata, error) in
//
//                    if error != nil {
//                        return
//                    }
//
//                    storageRef.downloadURL(completion: { (url, error) in
//
//                        if error != nil {
//                            return
//                        }
//
//                        self.setUserInfoWithImage(profileImageURL: url!.absoluteString, username: self.nameTextField.text!, email: self.emailTextField.text!, uid: uid!)
//                    })
//                }
//            }
//            self.setUserInfoWithoutImage(username: self.nameTextField.text!, email: self.emailTextField.text!, uid: uid!)
//
//            self.performSegue(withIdentifier: "SignUpToTabBar", sender: nil)
//        }
//    }
    
//    func setUserInfoWithImage (profileImageURL: String, username: String, email: String, uid: String) {
//        let ref = Database.database().reference()
//        let usersReference = ref.child("users")
//        let newUserReference = usersReference.child(uid)
//        newUserReference.setValue(["username": username, "email": email, "profile_image_url": profileImageURL])
//    }
//
//    func setUserInfoWithoutImage (username: String, email: String, uid: String) {
//        let ref = Database.database().reference()
//        let usersReference = ref.child("users")
//        let newUserReference = usersReference.child(uid)
//        newUserReference.setValue(["username": username, "email": email])
//    }
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
