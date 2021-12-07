//
//  User.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class Clubs: Codable{
    
    var clubName: String
    var clubOwner: String
    var clubLogo: String
    var verified: Bool
    var password: String
    var login: String
    var description: String
    var _id: String
    
    init(clubName: String, clubOwner: String, clubLogo: String, verified: Bool, password: String, login: String, description: String, _id: String) {
        self.clubName = clubName
        self.clubOwner = clubOwner
        self.clubLogo = clubLogo
        self.verified = verified
        self.password = password
        self.login = login
        self.description = description
        self._id = _id
    }
    
    func set(clubLogo: String) {
        self.clubLogo = clubLogo
    }
    func set(description: String) {
        self.description = description
    }
    func set(password: String) {
        self.password = password
    }
}
