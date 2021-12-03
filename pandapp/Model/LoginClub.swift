//
//  LoginClub.swift
//  pandapp
//
//  Created by Yassine Zitoun on 29/11/2021.
//

import Foundation

class LoginClub: Codable {
 
    
    var tokenClub: String
    var clubName: String
    var clubOwner: Int
    var clubLogo: String
    var verified: Bool
    var password: String
    var login: String
    //var _id: String
    
    init(tokenClub: String, clubName: String, clubOwner: Int, clubLogo: String, verified: Bool, password: String, login: String, _id: String) {
            self.tokenClub = tokenClub
            self.clubName = clubName
            self.clubOwner = clubOwner
            self.clubLogo = clubLogo
            self.verified = verified
            self.password = password
            self.login = login
            //self._id = _id
    }
}
