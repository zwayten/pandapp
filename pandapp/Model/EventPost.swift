//
//  eventPost.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class EventPost: Codable{
    
var publisheId: String
var state: Bool
var type: String
var place: String
var banner: String
var Time: String
var price: Double
var rate: Int
var title: String
var description: String
    

    init(publisheId: String, state: Bool, type: String, place: String, banner: String, Time: String, price: Double, rate: Int, title: String, description: String) {
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
    func set(banner: String){
        self.banner = banner
    }
    func set(Time: String){
        self.Time = Time
    }
    func set(price: Double){
        self.price = price
    }
    func set(rate: Int){
        self.rate = rate
    }
    func set(title: String){
        self.title = title
    }
    func set(description: String){
        self.description = description
    }
    

}
