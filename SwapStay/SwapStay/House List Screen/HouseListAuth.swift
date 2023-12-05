//
//  HouseListAuth.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/5/23.
//

import Foundation
import FirebaseAuth

extension HouseListViewController{
    
    // Load user infomation, including name and profile photo
    func loadUserInfo(){
        if let user = Auth.auth().currentUser {
            // User is signed in
            if let email = user.email,
               let name = user.displayName{
                // Successfully retrieved email and name
                print("Email: \(email)")
                print("Name: \(name)")
                self.houseListView.labelWelcome.text = "Welcome \(name)!"
                
                // check user photo url if nil or have one
                if let photoURL = user.photoURL{
                    print("Photo URL: \(photoURL)")
                    // if have one, load the phto
                    FirestoreUtility.loadImageToButton(from: photoURL, into: self.houseListView.profilePic)
                }else {
                    // Photo URL is nil
                    print("Warning: Photo URL is nil.")
                }
            } else {
                // Either email or name is nil
                print("Error: Unable to retrieve email or name.")
            }
        } else {
            // No user is signed in
            print("Error: No user is signed in.")
        }
    }
}
