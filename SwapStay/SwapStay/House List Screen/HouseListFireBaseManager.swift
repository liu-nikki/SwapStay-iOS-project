//
//  HouseListFireBaseManager.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/10/23.
//

import Foundation
import UIKit
import FirebaseAuth
//import FirebaseStorage
//import FirebaseFirestore

extension HouseListViewController{
    
    // Load user infomation, including name and profile photo
    func loadUserInfo(){
        if let user = Auth.auth().currentUser {
            // User is signed in
            if let email = user.email,
               let name  = user.displayName{
                // Set user name
                self.houseListScreen.labelWelcome.text = "Welcome \(name)!"
                
                // Check user photo url if nil or have one
                if let photoURL = user.photoURL{
                    print("Load IMG!")
                    FirestoreUtility.loadImageToButton(from: photoURL, into: self.houseListScreen.profilePic)
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
    
    func addPostUpdateListner(){
        self.db.collection("posts").order(by: "timestamp", descending: true)
            .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.houseList.removeAll()
                    for document in documents{
                        do{
                            let phtotoURL = try document.get("housePhoto") as? String ?? ""
                            print(phtotoURL)
                            
                            let post = try document.data(as: House.self)
                            
                            self.houseList.append(post)
                        }catch{
                            print(error)
                        }
                    }
                    self.houseListScreen.tableViewHouses.reloadData()
                }
            })
    }
}
