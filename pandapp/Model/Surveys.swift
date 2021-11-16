//
//  Surveys.swift
//  pandapp
//
//  Created by Yassine Zitoun on 15/11/2021.
//

import Foundation

class Surveys {

    var publisheId: String
    var creted_at: Date
    var state: Bool
    var titre: String
    var surveyLink: String
    
    init(publisheId: String, creted_at: Date, state: Bool, titre: String, surveyLink: String) {
        self.publisheId = publisheId
        self.creted_at = creted_at
        self.state = state
        self.titre = titre
        self.surveyLink = surveyLink
    }
}
