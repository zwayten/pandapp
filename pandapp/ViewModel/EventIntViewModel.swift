//
//  EventIntViewModel.swift
//  pandapp
//
//  Created by Yassine Zitoun on 6/12/2021.
//

import Foundation

class EventIntViewModel {
    
    public func addEventParticipation(eventInt: EventInt) {
        let parameters = ["userEmail": eventInt.userEmail,
                          "postId": eventInt.postId,
                          "_id": eventInt._id] as [String : Any]
        
        let  url = ConnectionDb.createConnection(urlStringModule: "EventInt")
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
