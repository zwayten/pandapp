//
//  RatePostViewModel.swift
//  pandapp
//
//  Created by yassine zitoun on 1/1/2022.
//

import Foundation
class RatePostViewModel {
    var token: String?
    public func ratePost(ratePost: RatePost) {
        let parameters = ["userEmail": ratePost.userEmail,
                          "postId": ratePost.postId,
                          "note": ratePost.note,
                          "_id": ratePost._id] as [String : Any]
        
        let  url = ConnectionDb.createConnection(urlStringModule: "ratePost")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let lastLogged = UserDefaults.standard.string(forKey: "lastLoggedIn")
        if lastLogged! == "user" {
         token = UserDefaults.standard.string(forKey: "token")
        }
        else if lastLogged == "club" {
             token = UserDefaults.standard.string(forKey: "tokenClub")
            }
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
