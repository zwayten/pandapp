//
//  EventViewModel.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation
import Alamofire
import UIKit


class EventPostViewModel {
    
    
    //var tableView: UITableView?
    
    
    
    
    public func fetchEventPost() {
        
        let  url = ConnectionDb.createConnection(urlStringModule: "event")
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
    
    public func addEventPost(eventPost: EventPost) {
        let parameters = ["publisheId": eventPost.publisheId, "state": eventPost.state, "type": eventPost.type, "place": eventPost.place, "banner": eventPost.banner, "Time": eventPost.Time, "price": eventPost.price, "rate": eventPost.rate, "title": eventPost.title, "description": eventPost.description] as [String : Any]
        
        let  url = ConnectionDb.createConnection(urlStringModule: "event")
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
