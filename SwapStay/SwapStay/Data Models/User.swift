//
//  User.swift
//  SwapStay
//
//  Created by Nikki Liu on 11/18/23.
//

import Foundation
import FirebaseFirestoreSwift

// adopt the Codable protocol to enable encoding and decoding.
struct User: Codable{
    @DocumentID var id: String?
    
    var username: String?
    var name: String
    var email: String
    var profileImageURL: String?
    var phone: String?
    var password: String?
    
    init(id: String? = nil, username: String? = nil, name: String, email: String, profileImageURL: String? = nil, phone: String? = nil, password: String? = nil) {
        self.id = id
        self.username = username
        self.name = name
        self.email = email
        self.profileImageURL = profileImageURL
        self.phone = phone
        self.password = password
    }
    
//    init(username: String, name: String, email: String, phone: String, profileImageURL: String, password: String) {
//        self.username = username
//        self.name  = name
//        self.email = email
//        self.phone = phone
//        self.profileImageURL = profileImageURL
//        self.password = password
//        
//    }
}
