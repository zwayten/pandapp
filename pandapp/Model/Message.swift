//
//  Message.swift
//  pandapp
//
//  Created by yassine zitoun on 1/1/2022.
//

import Foundation
class Messages: Codable {
   
    var content: String
    var whoSend: String
    var toSend: String
    var _id: String
    
    init(content: String, whoSend: String, toSend: String, _id: String) {
        self.content = content
        self.whoSend = whoSend
        self.toSend = toSend
        self._id = _id
    }
}
