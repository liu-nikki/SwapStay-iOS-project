//
//  House.swift
//  SwapStay
//
//  Created by Nikki Liu on 11/18/23.
//

import Foundation
// adopt the Codable protocol to enable encoding and decoding.
struct House: Codable{
    
    var address: String
    var city: String
    var state: String
    var zipcode: Int
    var time: TimeInterval
    var email: String
    
    init(address: String, city: String, state: String, zipcode: Int, time: TimeInterval, email: String) {
        self.address  = address
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.time = time
        self.email = email
    }
}
