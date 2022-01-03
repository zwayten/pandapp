//
//  EmploiViewModel.swift
//  pandapp
//
//  Created by Mac2021 on 3/1/2022.
//

import Foundation
class EmploiViewModel {
    public func addEmploi(emploi: Emploi) {
        let parameters = ["picture": emploi.picture,
                          "classe": emploi.classe] as [String : Any]
        let token = UserDefaults.standard.string(forKey: "token")
        let  url = ConnectionDb.createConnection(urlStringModule: "emploi")
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
