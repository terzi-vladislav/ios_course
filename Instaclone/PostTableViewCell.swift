//
//  PostTableViewCell.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 30.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var postPhoto: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var dateText: UITextView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        profilePicture.layer.cornerRadius = 0.5 * profilePicture.bounds.size.height
        profilePicture.layer.cornerRadius = 0.5 * profilePicture.bounds.size.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateAppearanceFor(_ url: String) {
        let url = URL(string: url)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.displayImage(image)
                }
            }
        }
    }

    override func prepareForReuse() {
        postPhoto.image = nil
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
    }

    private func displayImage(_ image: UIImage?) {
        if let _ = image {
            postPhoto.image = image
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
        } else {
            postPhoto.image = nil
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
        }
    }

}
