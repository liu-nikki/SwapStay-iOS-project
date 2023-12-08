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

    var houseImg:   Data
    var ownerName:  String
    var ownerEmail: String
    var post:       String
    var address:    String
//    var city: String
//    var state: String
//    var zipcode: Int
    
    var dateFrom:   Date?
    var dateTo:     Date?
    
    init(houseImg: Data, ownerName: String, ownerEmail: String, post: String, address: String, dateFrom: Date?, dateTo: Date?) {
        self.houseImg   = houseImg
        self.ownerName  = ownerName
        self.ownerEmail = ownerEmail
        self.post       = post
        self.address    = address
        self.dateFrom   = dateFrom
        self.dateTo     = dateTo
    }
}
