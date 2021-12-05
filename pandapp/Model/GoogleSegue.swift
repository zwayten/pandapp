//
//  GoogleSegue.swift
//  pandapp
//
//  Created by Yassine Zitoun on 5/12/2021.
//

import Foundation
struct GoogleSegue {
    var user: User
    var profilePictureUrl: URL
    
    init(user: User, profilePictureUrl: URL) {
            self.user = user
            self.profilePictureUrl = profilePictureUrl
        }
}
