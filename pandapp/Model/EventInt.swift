//
//  EventInt.swift
//  pandapp
//
//  Created by Yassine Zitoun on 6/12/2021.
//

import Foundation

class EventInt: Codable {
    
    var userEmail: String
    var postId: String
    var _id: String
    
    init(userEmail: String, postId: String, _id: String) {
        self.userEmail = userEmail
        self.postId = postId
        self._id = _id
    }
}
