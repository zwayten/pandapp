//
//  LoginUser.swift
//  pandapp
//
//  Created by Yassine Zitoun on 28/11/2021.
//

import Foundation

class LoginUser: Codable {
    var token: String
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
    var description: String

    //constructor
    init(token: String, email: String, password: String, phoneNumber: Int, profilePicture: String, FirstName: String, LastName: String, verified: Bool, identifant: String, className: String, role: String, social: Bool, description: String) {
        self.token = token
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.profilePicture = profilePicture
        self.FirstName = FirstName
        self.LastName = LastName
        self.verified = verified
        self.identifant = identifant
        self.className = className
        self.role = role
        self.social = social
        self.description = description

    }
    func set(email:String) {
        self.email = email
    }
    
    
}
