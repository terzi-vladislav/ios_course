//
//  Post.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 30.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import Foundation

class Post {
    var caption: String
    var photoUrl: String
    var dateOfPost: String = ""
    var user: String
    
    init(userName: String, captionText: String, photoUrlString: String, date: String) {
        user = userName
        caption = captionText
        photoUrl = photoUrlString
        if let range: Range<String.Index> = date.range(of: "day") {
            let indexDay: Int = date.distance(from: date.startIndex, to: range.lowerBound)
            let start = date.index(date.startIndex, offsetBy: indexDay + 5)
            let end = date.index(date.startIndex, offsetBy: indexDay + 7)
            let range = start..<end
            dateOfPost += String(date[range])
        }
        if let range: Range<String.Index> = date.range(of: "month") {
            let indexMonth: Int = date.distance(from: date.startIndex, to: range.lowerBound)
            let start = date.index(date.startIndex, offsetBy: indexMonth + 7)
            let end = date.index(date.startIndex, offsetBy: indexMonth + 9)
            let range = start..<end
            dateOfPost += " \(MonthName(monthNum: String(date[range])))"
        }
        if let range: Range<String.Index> = date.range(of: "year") {
            let indexYear: Int = date.distance(from: date.startIndex, to: range.lowerBound)
            let start = date.index(date.startIndex, offsetBy: indexYear + 6)
            let end = date.index(date.startIndex, offsetBy: indexYear + 10)
            let range = start..<end
            dateOfPost += " \(String(date[range]))"
        }
    }
    
    func MonthName(monthNum: String) -> String {
        if monthNum == "1 " {
            return "January"
        } else if monthNum == "2 " {
            return "February"
        } else if monthNum == "3 " {
            return "March"
        } else if monthNum == "4 " {
            return "April"
        } else if monthNum == "5 " {
            return "May"
        } else if monthNum == "6 " {
            return "June"
        } else if monthNum == "7 " {
            return "July"
        } else if monthNum == "8 " {
            return "August"
        } else if monthNum == "9 " {
            return "September"
        } else if monthNum == "10" {
            return "October"
        } else if monthNum == "11" {
            return "November"
        } else {
            return "December"
        }
    }
}
