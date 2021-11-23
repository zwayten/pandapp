//
//  eventPost.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class EventPost {
    
var publisheId: Int
var state: Bool
var type: String
var place: String
var banner: String
var Time: String
var price: Double
var rate: Int
    var title: String
    var description: String

    init(publisheId: Int, state: Bool, type: String, place: String, banner: String, Time: String, price: Double, rate: Int, title: String, description: String) {
        self.publisheId = publisheId
        self.state = state
        self.type = type
        self.place = place
        self.banner = banner
        self.Time = Time
        self.price = price
        self.rate = rate
        self.title = title
        self.description = description
    }
    

}
