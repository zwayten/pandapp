//
//  LostPostViewModel.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation


class LostPostViewModel {
    
    public func fetchLostPost() {
        
        
        let  url = ConnectionDb.createConnection(urlStringModule: "lostpost")
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
    
    public func addLostPost(lostPost: LostPost) {
        let parameters = ["publisheId": lostPost.publisheId,
                          "image": lostPost.image,
                          "state": lostPost.state,
                          "type": lostPost.type,
                          "place": lostPost.place,
                          "object": lostPost.object] as [String : Any]
        var token: String?
        let lastLogged = UserDefaults.standard.string(forKey: "lastLoggedIn")
        if lastLogged! == "user" {
            token = UserDefaults.standard.string(forKey: "token")
        }
        else if lastLogged == "club" {
             token = UserDefaults.standard.string(forKey: "tokenClub")
            }
        let  url = ConnectionDb.createConnection(urlStringModule: "lostpost")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token!)", forHTTPHeaderField: "Authorization")
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
