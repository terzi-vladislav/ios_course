//
//  ActivityTableViewCell.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 01.04.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    var userNames: [String] = [
        "billy_eilish",
        "tyler_oakley",
        "iisus_gospod",
        "untimedentist",
        "outsmartlool",
        "habitatcoe",
        "questionlobbling",
        "pogonino",
        "energyrodge",
        "crunchergore",
        "haggardsheriff",
        "sudsfor",
        "peetcatch",
        "seamstressleeds",
        "defeatbalsamic",
        "folicpumpion",
        "mixerindustry",
        "volumniaskelpie",
        "reactormango",
        "clashhours",
        "vestholing",
        "dosecoma",
        "wadpawn"
    ]
    
    var actions: [String] = [
        "liked your post.",
        "left a comment.",
        "followed you."
    ]

    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var actionText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        userPicture.layer.cornerRadius = 0.5 * userPicture.bounds.size.height
    }
    
    func setStyle(styleCode: Int, userPic: UIImage, userId: Int) {
        userPicture.image = userPic
        userName.text = userNames[userId % userNames.count]
        actionText.text = actions[userId % actions.count]
    }
    
    func updateStyle(userPic: UIImage) {
        userPicture.image = userPic
    }
}
