//
//  RegisterFirebaseManager.swift
//  SwapStay
//
//  Created by Nikki Liu on 11/18/23.
//

import Foundation
import UIKit
import FirebaseAuth

extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: display the progress indicator...
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name            = registerView.textFieldName.text,
           let email           = registerView.textFieldEmail.text,
           let password        = registerView.textFieldPassword.text,
           let confirmPassword = registerView.textFieldPasswordConfirm.text{
            if password != confirmPassword{
                self.hideActivityIndicator()
                self.showAlert()
                return
            }
            // Make sure email is lowercase
            let emailLC = email.lowercased()
            //Validations....
            Auth.auth().createUser(withEmail: emailLC, password: password) { result, error in
                if let error = error as NSError? {
                    self.hideActivityIndicator()
                    
                    if error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                        // Email already in use, show an alert to the user
                        self.showAlertWithMessage("This email is already in use. Please use a different email.")
                    } else {
                        // Other types of errors
                        print("Error: \(error.localizedDescription)")
                    }
                    return
                }
                // Once there is no error, which means User creation is successful...
                let user = User(name: name, email: emailLC)
                self.uploadProfilePhotoToStorage(user: user)
            }
        }
    }
    
    // Helper function to show an alert with a specific message
    func showAlertWithMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(user: User, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        // Set user name and photo URL
        changeRequest?.displayName = user.name
        changeRequest?.photoURL    = photoURL
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                self.saveUserToFirestore(user: user)
            }else{
                // There was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    //MARK: Logic to add a contact to Firestore...
    func saveUserToFirestore(user: User) {
        
        // Get a reference to the email document
        let emailDocument = db.collection("users").document(user.email)
        let userData: [String: String] = ["name": user.name]

        do {
            // Add user name as a field to the user email, which is the docuemnt ID
            try emailDocument.setData(from: userData, completion: { (error) in
                if let error = error {
                    print("Error setting user data: \(error.localizedDescription)")
                } else {
                    print("User email data successfully written!")
                }
            })
        } catch {
            print("Error encoding user data: \(error.localizedDescription)")
        }
    
        let dummyData: [String: String] = ["email": "This is dummy"]
        do {
            // Create a collection "chat" with dummy data
            try emailDocument.collection("chats").document("Dummy ID").setData(from: dummyData, completion: {(error) in
                if let error = error {
                    print("Error setting contacts data: \(error.localizedDescription)")
                } else {
                    print("User and contacts data successfully written!")
                    //MARK: hide the progress indicator...
                    self.hideActivityIndicator()
                    // Notify the screen to update and will redirect to Login Screen
                    self.notificationCenter.post(name: .registerSuccessfully, object: "")
                }
            })
        } catch {
            print("Error encoding contacts data: \(error.localizedDescription)")
        }
    }
    
    func uploadProfilePhotoToStorage(user: User){
        var profilePhotoURL:URL?
        
        //MARK: Upload the profile photo if there is any...
        if let image = pickedImage{
            if let jpegData = image.jpegData(compressionQuality: 80){
                // Create a storage reference from our storage service
                let storageRef = storage.reference()
                // Create a child reference imagesRef now points to "images"
                // Instead of using UUID, use email address as the id of user icon
                let imageRef = storageRef.child("user_icons/\(user.email).jpg") // TODO: rename it
                // Upload the file to the path "user_icons/\(email).jpg"
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        // If there is no error, donwload the url
                        imageRef.downloadURL(completion: {(url, error) in
                            // If there is no erro, assign the url to profilePhotoURL
                            if error == nil{
                                profilePhotoURL = url
                                self.setNameOfTheUserInFirebaseAuth(user: user, photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        }else{
            self.setNameOfTheUserInFirebaseAuth(user: user, photoURL: profilePhotoURL)
        }
        
    }
}

