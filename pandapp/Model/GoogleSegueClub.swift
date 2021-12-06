//
//  GoogleSegueClub.swift
//  pandapp
//
//  Created by Yassine Zitoun on 5/12/2021.
//

import Foundation
struct GoogleSegueClub {
    var club: Clubs
    var profilePictureUrl: URL
    
    init(club: Clubs, profilePictureUrl: URL) {
            self.club = club
            self.profilePictureUrl = profilePictureUrl
        }
}
