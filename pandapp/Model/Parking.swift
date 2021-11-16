//
//  Parking.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class Parking {

    var longatitude: Int
    var latatitude: Int
    var creted_at: Date
    var userId: String
    
    init(longatitude: Int, latatitude: Int, creted_at: Date, userId: String) {
        self.longatitude = longatitude
        self.latatitude = latatitude
        self.creted_at = creted_at
        self.userId = userId
    }
}
