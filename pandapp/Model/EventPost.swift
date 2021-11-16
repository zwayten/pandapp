//
//  eventPost.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class EventPost {
    
var publisheId: Int
var publishedAt: Date
var state: Bool
var type: String
var place: String
var banner: String
var Time: Date
var price: Double
var rate: Int

    init(publisheId: Int, publishedAt: Date, state: Bool, type: String, place: String, banner: String, Time: Date, price: Double, rate: Int) {
        self.publisheId = publisheId
        self.publishedAt = publishedAt
        self.state = state
        self.type = type
        self.place = place
        self.banner = banner
        self.Time = Time
        self.price = price
        self.rate = rate
    }
    

}
