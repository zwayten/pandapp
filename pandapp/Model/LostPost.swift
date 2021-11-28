//
//  LostPost.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class LostPost {
    
    var publisheId: String
    //var publishedAt: Date
    var state: Bool
    var type: String
    var object: String
    var place: String
    var image: String
    
    init(publisheId: String, state: Bool, type: String, object: String, place: String, image: String) {
        self.publisheId = publisheId
       //self.publishedAt = publishedAt
        self.state = state
        self.type = type
        self.object = object
        self.place = place
        self.image = image
    }
    
    func set(publisheId: String){
        self.publisheId = publisheId
    }
    func set(state: Bool){
        self.state = state
    }
    func set(type: String){
        self.type = type
    }
    func set(place: String){
        self.place = place
    }
    func set(object: String){
        self.object = object
    }
    func set(image: String){
        self.image = image
    }
    
    
}
