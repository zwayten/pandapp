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
    private static let urlString = "http://192.168.92.1:3000/"
    public static func createConnection(urlStringModule: String) -> URL {
        let  urlTempString = ConnectionDb.urlString + urlStringModule
        let urlc = URL(string: urlTempString)
        return urlc!
    }
    public static func baserequest() ->String {	
        return "http://192.168.92.1:3000/"
    }
}
