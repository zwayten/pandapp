//
//  Emploi.swift
//  pandapp
//
//  Created by Mac2021 on 3/1/2022.
//

import Foundation

class Emploi: Codable {
    
    
    var picture: String
    var classe: String
    init(picture: String, classe: String) {
        self.picture = picture
        self.classe = classe
    }
}
