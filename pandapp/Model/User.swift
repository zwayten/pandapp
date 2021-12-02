//
//  User.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class User: Codable{
    
    

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
    init(email: String, password: String, phoneNumber: Int, profilePicture: String, FirstName: String, LastName: String, verified: Bool, identifant: String, className: String, role: String, social: Bool, description: String) {
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
    
    //setters
    func setEmail(email: String){
        self.email = email
    }
    func setPassword(password: String){
        self.password = password
    }
    func setProfilepicture(profilePicture: String){
        self.profilePicture = profilePicture
    }
    func setPhoneNumber(phoneNumber: Int){
        self.phoneNumber = phoneNumber
    }
    func setFirstName(FirstName: String){
        self.FirstName = FirstName
    }
    func setLastName(LastName: String){
        self.LastName = LastName
    }
    func setVerified(verified: Bool){
        self.verified = verified
    }
    func setSocial(social: Bool){
        self.social = social
    }
    func setIdentifant(identifant: String){
        self.identifant = identifant
    }
    func setRole(role: String){
        self.role = role
    }
    func setClassName(className: String){
        self.className = className
    }
    func setDescription(description: String){
        self.description = description
    }
    
    // getters
    func getEmail() -> String{
        return self.email
    }
    func getPassword() -> String{
        return self.password
    }
    func getPhoneNumber() -> Int{
        return self.phoneNumber
    }
    func getFirstName() -> String{
        return self.FirstName
    }
    func getLastName() -> String{
        return self.LastName
    }
    func getVerified() -> Bool{
        return self.verified
    }
    func getSocial() -> Bool{
        return self.social
    }
    func getIdentifant() -> String{
        return self.identifant
    }
    func getRole() -> String{
        return self.role
    }
    func getClassName() -> String{
        return self.className
    }
}
