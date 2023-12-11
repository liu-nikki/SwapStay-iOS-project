//
//  Chat.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/8/23.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit

// adopt the Codable protocol to enable encoding and decoding.
struct Chat: Codable{
    @DocumentID var id: String?
    var name:    String
    var email:   String
    var address: String
    var date:    Date
    
    init(name: String, email: String, address: String, date: Date) {
        self.name    = name
        self.email   = email
        self.address = address
        self.date    = date
    }
    
    
    
}
