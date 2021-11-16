//
//  User.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class Clubs {
    
    var clubName: String
    var clubOwner: Int
    var clubLogo: String
    var verifed: Bool
    var passward: String
    var login: String
    
    init(clubName: String, clubOwner: Int, clubLogo: String, verifed: Bool, passward: String, login: String) {
        self.clubName = clubName
        self.clubOwner = clubOwner
        self.clubLogo = clubLogo
        self.verifed = verifed
        self.passward = passward
        self.login = login
    }
    
}
