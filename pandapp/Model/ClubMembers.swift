//
//  ClubMembers.swift
//  pandapp
//
//  Created by Yassine Zitoun on 3/12/2021.
//

import Foundation

class ClubMembers: Codable {
    
    var clubName: String
    var userEmail: String
    var memberPicture: String
    var state: Bool
    var _id: String
    
    init(clubName: String, userEmail: String, memberPicture: String, state: Bool, _id: String) {
        self.clubName = clubName
        self.userEmail = userEmail
        self.memberPicture = memberPicture
        self.state = state
        self._id = _id
    }
}
