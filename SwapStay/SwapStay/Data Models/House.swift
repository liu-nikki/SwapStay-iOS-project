//
//  House.swift
//  SwapStay
//
//  Created by Nikki Liu on 11/18/23.
//

import Foundation
import FirebaseFirestoreSwift
import UIKit

// adopt the Codable protocol to enable encoding and decoding.
struct House: Codable{
    @DocumentID var id: String?

    var profilePhotoURL:   String
    var ownerName:  String
    var ownerEmail: String
    var address:    String
    var city: String
    var state: String
    var zip: String
    var startDate:   String
    var endDate:     String
    var description: String
    
    init(profilePhotoURL: String, ownerName: String, ownerEmail: String, address: String, city: String, state: String, zip: String, startDate: String, endDate: String, description: String) {
        self.profilePhotoURL   = profilePhotoURL
        self.ownerName  = ownerName
        self.ownerEmail = ownerEmail
        self.address    = address
        self.city       = city
        self.state      = state
        self.zip        = zip
        self.startDate   = startDate
        self.endDate     = endDate
        self.description = description
    }
}

