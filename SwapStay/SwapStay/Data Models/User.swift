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

    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name  = name
        self.email = email
    }
}
