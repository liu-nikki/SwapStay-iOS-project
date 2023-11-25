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
    var profileImageURL: String?
    var phone: String?
    var address: Address?
    
    init(id: String? = nil, name: String, email: String, profileImageURL: String? = nil, phone: String? = nil, address: Address? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.profileImageURL = profileImageURL
        self.phone = phone
        self.address = address
    }
        
}

struct Address: Codable, Equatable{
    var line1: String
    var line2: String?
    var city: String
    var state: String
    var zip: String
    
    init(line1: String, line2: String? = nil, city: String, state: String, zip: String) {
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.state = state
        self.zip = zip
    }
    
    func formattedAddress() -> String {
        var addressString = "\(line1)"
        
        if let line2 = line2, !line2.isEmpty {
            addressString += "\n\(line2)"
        }
        
        addressString += "\n\(city), \(state) \(zip)"
        return addressString
    }
    
    // Function to convert Address to a dictionary
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "line1": line1,
            "city": city,
            "state": state,
            "zip": zip
        ]

        // Include line2 only if it's not nil
        if let line2 = line2 {
            dict["line2"] = line2
        }

        return dict
    }

}
