//
//  AddPhotoExtraPage.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 19.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class AddPhotoExtraPage: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        setUpNavigationBar()
        shareButton.layer.cornerRadius = 0.5 * shareButton.bounds.size.height
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
        shareButton.isHidden = true
        shareButton.isEnabled = false
        caption.text = "Your text here"
        caption.textColor = .lightGray
        caption.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Your text here" && textView.textColor == .lightGray) {
            textView.text = ""
            textView.textColor = .white
        }
        textView.becomeFirstResponder() //Optional
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = "Your text here"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func sgareBttn_touchUpInside(_ sender: Any) {
        ProgressHUD.show("Posting", interaction: false)
        if let profileIMG = self.selectedImage, let imageData = profileIMG.jpegData(compressionQuality: 0.3) {
            let uid = (Auth.auth().currentUser?.uid)!
            let photoIdString = NSUUID().uuidString
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_REF).child("posts").child(photoIdString)
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in

                if error != nil {
                    self.shareButton.isEnabled = false
                    ProgressHUD.showError(error?.localizedDescription)
                    return
                }
                
                storageRef.downloadURL(completion: { (url, error) in

                    if error != nil {
                        self.shareButton.isEnabled = false
                        ProgressHUD.showError(error?.localizedDescription)
                        return
                    }
                    
                    self.shareButton.isEnabled = true
                    let ref = Database.database().reference()
                    let userReference = ref.child("users").child(uid).child("posts")
                    let newPhotoReference = userReference.child(photoIdString)
                    newPhotoReference.setValue(["photo": url!.absoluteString, "caption": self.caption.text!, "date": "\(Calendar.current.dateComponents([.year, .month, .day], from: Date()))"])
                    ProgressHUD.showSuccess("Successful")
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
}

extension AddPhotoExtraPage: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            selectedImage = image
            photo.image = image
            photo.alpha = 1.0
            photo.contentMode = .scaleAspectFill
            shareButton.isHidden = false
            shareButton.isEnabled = true
        }
        
        dismiss(animated: true, completion: nil)
        view.endEditing(true)
    }
}
