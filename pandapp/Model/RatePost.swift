//
//  RatePost.swift
//  pandapp
//
//  Created by yassine zitoun on 1/1/2022.
//

import Foundation

class RatePost: Codable {
    
    var userEmail: String
    var postId: String
    var note: Int
    var _id: String
    
    init(userEmail: String, postId: String, note: Int, _id: String) {
        self.userEmail = userEmail
        self.postId = postId
        self.note = note
        self._id = _id
    }
}
