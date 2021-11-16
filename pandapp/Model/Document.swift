//
//  Document.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class Document {

    var documentType: String
    var claimedId: String
    var createdAT: Date
    var numcopies: Int
    var docLanguage: String
    
    init(documentType: String, claimedId: String, createdAT: Date, numcopies: Int, docLanguage: String) {
        self.documentType = documentType
        self.claimedId = claimedId
        self.createdAT = createdAT
        self.numcopies = numcopies
        self.docLanguage = docLanguage
    }
    
}
