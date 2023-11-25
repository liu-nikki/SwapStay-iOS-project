//
//  FirestoreUtility.swift
//  SwapStay
//
//  Created by Yu Zou on 11/24/23.
//

import Foundation
import FirebaseFirestore

final class FirestoreUtility {

    // Private initializer to prevent instantiation
    private init() {}

    // Static method to fetch a user
    static func fetchUser(from documentId: String, completion: @escaping (Result<User, Error>) -> Void) {
        let db = Firestore.firestore()
        var user: User?
        db.collection("users").document(documentId).getDocument { (document, error) in
            if let error = error {
                print("Error getting document: \(error)")
                completion(.failure(error))
            } else if let document = document, document.exists {
                let documentData = document.data()
                print("Document data: \(String(describing: documentData))")
                let userName = document.get("name") as? String ?? ""
                let userPhone = document.get("phoneNum") as? String ?? ""
                let profileImageURL = document.get("profileImageURL") as? String ?? ""
                if let address = document.get("address") as? [String: Any]{
                    let line1 = address["line1"] as? String ?? ""
                    let line2 = address["line2"] as? String ?? ""
                    let city = address["city"] as? String ?? ""
                    let state = address["state"] as? String ?? ""
                    let zip = address["zip"] as? String ?? ""
                    let userAddress = Address(line1: line1, line2: line2, city: city, state:state, zip: zip)
                    user = User(
                        name: userName,
                        email: documentId,
                        profileImageURL: profileImageURL,
                        phone: userPhone,
                        address: userAddress)
                 } else {
                     user = User(
                        name: userName,
                        email: documentId,
                        profileImageURL: profileImageURL,
                        phone: userPhone)
                }
                
                completion(.success(user!))

                
            } else {
                print("Document does not exist")
            }
        
        }
        
    }

    // You can add more static methods here
    static func emailToFileName(email: String) -> String {
        // Replace illegal characters
        let cleanedEmail = email.replacingOccurrences(of: "@", with: "_")
                                 .replacingOccurrences(of: ".", with: "_")
        
        // Optionally, you can truncate the file name if it exceeds a certain length
        // This depends on your requirements and the file system's limitations
        // let truncatedEmail = String(cleanedEmail.prefix(255)) // Example for a 255 character limit

        return cleanedEmail
    }
    
    static func loadImageToButton(from url: URL, into button: UIButton) {
        // Perform the data task on a background thread
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url) {
                // Convert the Data object into an image
                if let image = UIImage(data: data) {
                    // Dispatch back to the main thread to update the UI
                    DispatchQueue.main.async {
                        button.setImage(image, for: .normal)
                    }
                }
            }
        }
    }
    
    static func loadImageToImage(from url: URL, into imageView: UIImageView) {
        // Perform the data task on a background thread
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url) {
                // Convert the Data object into an image
                if let image = UIImage(data: data) {
                    // Dispatch back to the main thread to update the UI
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }
        }
    }
    
}
