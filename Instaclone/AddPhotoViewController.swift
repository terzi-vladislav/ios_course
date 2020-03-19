//
//  AddPhotoViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 11.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {
    
    var mainView: MainView {
        return self.view as! MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        self.view.addSubview(navBar)

        let navItem = UINavigationItem(title: "Add Photo")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(AddPhotoViewController.cancelBttn))
        navItem.leftBarButtonItem = cancelButton

        navBar.setItems([navItem], animated: false)
        self.view.backgroundColor = UIColor(displayP3Red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
    }
    
    @objc func cancelBttn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
    }
}

class MainView: UIView {
    var shareAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupConstraints()
        addActions()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.addSubview(contentView)
        self.addSubview(shareButton)
    }

    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupContentViewConstraints()
        setupShareButtonConstraints()
    }

    func addActions() {
        shareButton.addTarget(self, action: #selector(self.onShareButton), for: .touchUpInside)
    }

    @objc func onShareButton() {
        shareAction?()
    }

    fileprivate func setupContentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
    }

    fileprivate func setupShareButtonConstraints() {
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 64.0 ).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 286.0).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }

    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.backgroundColor = CGColor(genericGrayGamma2_2Gray: 1.0, alpha: 0.1)
        return view
    }()

    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SHARE", for: .normal)
        button.layer.cornerRadius = 22
        button.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.15)
        button.tintColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return button
    }()
}
