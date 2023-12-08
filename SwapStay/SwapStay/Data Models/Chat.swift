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
    var address: String
    var date:    String
    
    init(name: String, address: String, date: String) {
        self.name    = name
        self.address = address
        self.date    = date
    }
    
    
    
}
