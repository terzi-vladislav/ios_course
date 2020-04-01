//
//  PhotoTableViewCell.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 19.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        photo.image = nil
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
    }

    private func displayImage(_ image: UIImage?) {
        if let _ = image {
            photo.image = image
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
        } else {
            photo.image = nil
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
        }
    }


}
