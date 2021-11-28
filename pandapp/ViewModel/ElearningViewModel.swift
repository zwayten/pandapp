//
//  ElearningViewModel.swift
//  pandapp
//
//  Created by Yassine Zitoun on 27/11/2021.
//

import Foundation
import Alamofire

class ElearningViewModel {

    public func fetchcourse() {
        
        let  url = ConnectionDb.createConnection(urlStringModule: "elearning")
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
    
    public func addCoursePost(eLearning: Elearning) {
        let parameters = ["publisheId": eLearning.publisheId,
                          "className":  eLearning.className,
                          "module":     eLearning.module,
                          "courseName": eLearning.courseName,
                          "courseFile": eLearning.courseFile] as [String : Any]
        
        let  url = ConnectionDb.createConnection(urlStringModule: "elearning")
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
