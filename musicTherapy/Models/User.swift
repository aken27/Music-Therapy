//
//  User.swift
//  musicTherapy
//
//  Created by kkerors on 09.01.2021.
//

import Foundation

struct User: Codable {
    
    var id: String?
    var nickname: String
    var givenName: String
    var familyName: String?
    var phone: String?
    var description: String?
    
    init(id: String,
         nickname: String,
         givenName: String,
         familyName: String,
         phone: String?,
         description: String?
        ){
        self.id = id
        self.nickname = nickname
        self.givenName = givenName
        self.familyName = familyName
        self.phone = phone
        self.description = description
    }
    
}
