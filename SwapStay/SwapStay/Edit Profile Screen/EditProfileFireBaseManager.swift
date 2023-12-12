//
//  EditProfileFireBaseManager.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/12/23.
//

import Foundation
import FirebaseAuth

extension EditProfileViewController{
    
    func uploadProfilePhotoToStorage(user: User, updateImage: Bool){
        var profilePhotoURL:URL?
        
        //MARK: Upload the profile photo if there is any...
        if let image = pickedImage, updateImage == true{
            if let jpegData = image.jpegData(compressionQuality: 80){
                // Create a storage reference from our storage service
                let storageRef = storage.reference()
                // Create a child reference imagesRef now points to "images"
                // Instead of using UUID, use email address as the id of user icon
                let imageRef = storageRef.child("user_icons/\(user.email).jpg") // TODO: rename it
                // Delete the previous user image
                imageRef.delete { error in
                  if let error = error {
                    // Uh-oh, an error occurred!
                      print(error)
                  } else {
                      print("File deleted successfully")
                      // Upload the file to the path "user_icons/\(email).jpg"
                      let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                          if error == nil{
                              // If there is no error, donwload the url
                              imageRef.downloadURL(completion: {(url, error) in
                                  // If there is no erro, assign the url to profilePhotoURL
                                  if error == nil{
                                      profilePhotoURL = url
                                      self.updateTheUserInFirebaseAuth(user: user, photoURL: profilePhotoURL)
                                  }
                              })
                          }
                      })
                  }
                }
                

            }
        }else{
            self.updateTheUserInFirebaseAuth(user: user, photoURL: profilePhotoURL)
        }
    }
    
    // Update user information in FirebaseAuth
    func updateTheUserInFirebaseAuth(user: User, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName  = user.name
        if photoURL != nil{
            changeRequest?.photoURL = photoURL
        }
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                self.updateEditInfoFirestore(user: user)
            }else{
                // There was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func updateEditInfoFirestore(user: User){
        let userEmailRef = db.collection("users").document(user.email)
        
        // update the field
        userEmailRef.updateData([
          "name"  : user.name,
          "phone" : user.phone
        ]) { err in
          if let err = err {
            print("Error updating document: \(err)")
          } else {
            print("Document successfully updated")
          }
        }
    }
}
