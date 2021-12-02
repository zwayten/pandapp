//
//  user.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation


class UserViewModel {
    
    
    public func fetchUsers() {
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        let  url = ConnectionDb.createConnection(urlStringModule: "user")
        print("test 1")
        let session = URLSession.shared
        print("test 2")
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print("test response")
                print(response)
            }
            
            if let data = data {
                print("test data")
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("test json")
                    print(json)
                } catch {
                    print(error)
                }
                
            }
        }.resume()
    }
    
    public func registerUser(user: User) {
        let parameters = ["identifant": user.identifant, "email": user.email, "password": user.password, "phoneNumber": user.phoneNumber, "FirstName": user.FirstName, "LastName": user.LastName, "social": user.social, "role": user.role, "verified": user.verified, "className": user.className, "profilePicture": user.profilePicture, "description": user.description] as [String : Any]
        
        let  url = ConnectionDb.createConnection(urlStringModule: "user")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    
    
}
