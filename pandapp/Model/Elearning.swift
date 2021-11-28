//
//  Elearning.swift
//  pandapp
//
//  Created by Yassine Zitoun on 27/11/2021.
//

import Foundation

class Elearning: Codable {
    
    var publisheId: String
    var publishedAt: String
    var className: String
    var module: String
    var courseName: String
    var courseFile: String

    init(publisheId: String, publishedAt: String, className: String, module: String, courseName: String, courseFile: String) {
        self.publisheId = publisheId
        self.publishedAt = publishedAt
        self.className = className
        self.module = module
        self.courseName = courseName
        self.courseFile = courseFile
    }
    
    func set(courseFile: String){
        self.courseFile = courseFile
    }
}
