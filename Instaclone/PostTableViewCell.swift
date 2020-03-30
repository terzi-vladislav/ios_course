//
//  PostTableViewCell.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 30.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postPhoto: UIImageView!
    @IBOutlet weak var captionText: UITextView!
    @IBOutlet weak var dateText: UITextView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicture.layer.cornerRadius = 0.5 * profilePicture.bounds.size.height
        profilePicture.layer.cornerRadius = 0.5 * profilePicture.bounds.size.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
