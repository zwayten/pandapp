//
//  LostPost.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class LostPost {
    
    var publisheId: Int
    var publishedAt: Date
    var state: Bool
    var type: String
    var object: String
    var place: String
    var image: String
    
    init(publisheId: Int, publishedAt: Date, state: Bool, type: String, object: String, place: String, image: String) {
        self.publisheId = publisheId
        self.publishedAt = publishedAt
        self.state = state
        self.type = type
        self.object = object
        self.place = place
        self.image = image
    }
    
    
}
