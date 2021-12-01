//
//  Document.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class Document: Codable {

    var documentType: String
    var claimedId: String
    var createdAT: String
    var numcopies: Int
    var docLanguage: String
    var _id: String
    
    init(documentType: String, claimedId: String, createdAT: String, numcopies: Int, docLanguage: String, _id: String) {
        self.documentType = documentType
        self.claimedId = claimedId
        self.createdAT = createdAT
        self.numcopies = numcopies
        self.docLanguage = docLanguage
        self._id = _id
    }
    
}
