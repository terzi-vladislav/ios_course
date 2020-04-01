//
//  PhotoTripletTableViewCell.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 01.04.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

var tappedImage: UIImage?

class PhotoTripletTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var firstPhoto: UIImageView!
    @IBOutlet weak var secondPhoto: UIImageView!
    @IBOutlet weak var thirdPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstButton.addTarget(self, action: #selector(self.firstBttn), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(self.secondBttn), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(self.thirdBttn), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func firstBttn(_ sender: Any) {
        tappedImage = firstPhoto.image
    }
    
    @IBAction func secondBttn(_ sender: Any) {
        tappedImage = secondPhoto.image
    }
    
    @IBAction func thirdBttn(_ sender: Any) {
        tappedImage = thirdPhoto.image
    }

}
