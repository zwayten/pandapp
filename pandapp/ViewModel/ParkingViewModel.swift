//
//  ParkingViewModel.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation


class ParkingViewModel {
    var token: String?
    public func addParking(parking: Parking) {
        let parameters = ["longatitude": parking.longatitude,
                          "latatitude": parking.latatitude,
                          "userId": parking.userId] as [String : Any]
        let lastLogged = UserDefaults.standard.string(forKey: "lastLoggedIn")
        if lastLogged! == "user" {
         token = UserDefaults.standard.string(forKey: "token")
        }
        else if lastLogged == "club" {
             token = UserDefaults.standard.string(forKey: "tokenClub")
            }
        let  url = ConnectionDb.createConnection(urlStringModule: "parking")
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
