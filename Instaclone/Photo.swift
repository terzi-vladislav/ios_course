//
//  Photo.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 19.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import Foundation

struct Photo {
    
    let picUrl: String
    
}

extension Photo {
    
    init?(dict: NSDictionary) {
        guard
            let picUrl = dict["picUrl"] as? String
            else { return nil }
        
        self.picUrl = picUrl
    }
    
}
