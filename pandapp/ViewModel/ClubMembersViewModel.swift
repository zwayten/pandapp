//
//  ClubMembersViewModel.swift
//  pandapp
//
//  Created by Yassine Zitoun on 3/12/2021.
//

import Foundation

class ClubMembersViewModel {
    
    public func addMemberToClub(club: ClubMembers) {
        let parameters = ["clubName": club.clubName,
                          "userEmail": club.userEmail,
                          "memberPicture": club.memberPicture,
                          "state": club.state,
                          "_id": club._id] as [String : Any]
        
        let  url = ConnectionDb.createConnection(urlStringModule: "clubMembers")
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
