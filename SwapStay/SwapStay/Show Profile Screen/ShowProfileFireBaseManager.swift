//
//  ShowProfileFireBaseManager.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/10/23.
//

import Foundation
import UIKit
import FirebaseAuth

extension ShowProfileViewController{
    
    func loadProfileImage2(){
        if let user = Auth.auth().currentUser {
            
            // Check user photo url if nil or have one
            if let photoURL = user.photoURL{
                // Load image first because it will take time to download it
                FirestoreUtility.loadImageToImage(from: photoURL, into: self.showProfileScreen.imageProfile)
            }else {
                // Photo URL is nil
                print("Warning: Photo URL is nil.")
            }
                
            // Get document reference by user email
            if let email = user.email{
                let docRef = db.collection("users").document("\(email)")
               
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        do {
                            // Try to decode the document into a User instance
                            let user = try document.data(as: User.self)
                            self.updateUIWithUserDetails(user)
                            
                        } catch {
                            print("Error decoding document: \(error.localizedDescription)")
                        }
                    } else {
                        print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
                
            }
                
        } else {
            // No user is signed in
            print("Error: No user is signed in.")
        }
    }
}
