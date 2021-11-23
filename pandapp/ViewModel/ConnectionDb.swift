//
//  ConnectionDb.swift
//  pandapp
//
//  Created by Yassine Zitoun on 22/11/2021.
//

import Foundation

class ConnectionDb {
    static var shared = ConnectionDb()
    private init() { }
    private static let urlString = "http://192.168.109.1:3000/"
    public static func createConnection(urlStringModule: String) -> URL {
        var  urlTempString = ConnectionDb.urlString + urlStringModule
        var urlc = URL(string: urlTempString)
        return urlc!
    }
}
