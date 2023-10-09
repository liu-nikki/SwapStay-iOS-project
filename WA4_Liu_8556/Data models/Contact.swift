//
//  Contact.swift
//  WA4_Liu_8556
//
//  Created by Nikki Liu on 10/2/23.
//

import Foundation

struct Contact{
    var name: String?
    var email: String?
    var phone: Int?
    var type: String?
    var address: String?
    var city: String?
    var zip: String?

    
    init(name: String? = nil, email: String? = nil, phone: Int? = nil, type: String? = nil, address: String? = nil, city: String? = nil, zip: String? = nil) {
        self.name = name
        self.email = email
        self.phone = phone
        self.type = type
        self.address = address
        self.city = city
        self.zip = zip
    }
    
}

