//
//  OtherPost.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class OtherPost {

    var publisheId: Int
    var publishedAt: Date
    var state: Bool
    var title: String
    var type: String
    var description: String
    var place: String
    var image: String
    
    init(publisheId: Int, publishedAt: Date, state: Bool, title: String, type: String, description: String, place: String, image: String) {
        self.publisheId = publisheId
        self.publishedAt = publishedAt
        self.state = state
        self.title = title
        self.type = type
        self.description = description
        self.place = place
        self.image = image
    }
}
