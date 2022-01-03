//
//  Parking.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class Parking: Codable {
     
    

    var longatitude: Double
    var latatitude: Double
    var userId: String
    
    
    init(longatitude: Double, latatitude: Double, userId: String) {
       self.longatitude = longatitude
       self.latatitude = latatitude
       self.userId = userId
   }
    
}
