//
//  User.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class User {

    var email: String
    var password: String
    var phoneNumber: Int
    var profilePicture: String
    var FirstName: String
    var LastName: String
    var verified: Bool
    var social: Bool
    var identifant :String
    var role :String
    var className: String
    var parkId: Int
     
    func setPhoneNumber(phoneNumber: Int){
        self.phoneNumber = phoneNumber
    }
    
    init(email: String, password: String, phoneNumber: Int, profilePicture: String, FirstName: String, LastName: String, verified: Bool, identifant: String, className: String, parkId: Int, role: String, social: Bool) {
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.profilePicture = profilePicture
        self.FirstName = FirstName
        self.LastName = LastName
        self.verified = verified
        self.identifant = identifant
        self.className = className
        self.parkId = parkId
        self.role = role
        self.social = social
    }
}
