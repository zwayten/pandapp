//
//  MessagesViewModel.swift
//  pandapp
//
//  Created by yassine zitoun on 1/1/2022.
//

import Foundation
class MessagesViewModel {
    
    
    
    public func sendMessages(messages: Messages) {
        let parameters = ["content": messages.content,
                          "whoSend": messages.whoSend,
                          "toSend": messages.toSend,
                          "_id": messages._id] as [String : Any]
        
        let  url = ConnectionDb.createConnection(urlStringModule: "message")
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
