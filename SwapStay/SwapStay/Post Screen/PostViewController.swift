//
//  PostViewController.swift
//  SwapStay
//
//  Created by Kaylin Lau on 12/5/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class PostViewController: UIViewController {
    
    let addPostScreen = PostView()
    
    let db = Firestore.firestore()
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = addPostScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        printCurrentUserDetails()
        
        addPostScreen.postButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
    }
    
    // MARK: create a post
    @objc func createPost() {
        guard let user = UserManager.shared.currentUser else { return }
        
        let postId = db.collection("posts").document().documentID
        let ownerName = user.name
        let profilePhotoURL = user.profileImageURL ?? ""
        let ownerEmail = user.email
        let startDate = addPostScreen.dateFromButton.text ?? ""
        let endDate = addPostScreen.dateToButton.text ?? ""
        let description = addPostScreen.descriptionTextView.text ?? ""
        let address = addPostScreen.addressTextField.text ?? ""
        let city = addPostScreen.cityTextField.text ?? ""
        let state = addPostScreen.stateTextField.text ?? ""
        let zip = addPostScreen.zipTextField.text ?? ""

        // Create post dictionary
        let postDict: [String: Any] = [
            "postId": postId,
            "ownerName": ownerName,
            "profilePhotoURL": profilePhotoURL,
            "ownerEmail": ownerEmail,
            "startDate": startDate,
            "endDate": endDate,
            "description": description,
            "address": address,
            "city": city,
            "state": state,
            "zip": zip
        ]

        // Save post in user's personal post collection
        db.collection("users").document(ownerEmail).collection("posts").document(postId).setData(postDict) { error in
            if let error = error {
                print("Error saving post to user's collection: \(error)")
            } else {
                print("Post saved to user's collection successfully.")
            }
        }

        // Save post in global post collection
        db.collection("posts").document(postId).setData(postDict) { error in
            if let error = error {
                print("Error saving post to global collection: \(error)")
            } else {
                print("Post saved to global collection successfully.")
            }
        }
        
        // Go back to HouseListScreen
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    func deletePost(postId: String) {
        guard let user = UserManager.shared.currentUser else {
            print("No current user available")
            return
        }

        let email = user.email // Directly use email as it's not optional

        // Fetch the post to check the owner
        let postRef = db.collection("posts").document(postId)
        postRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let ownerEmail = document.data()?["ownerEmail"] as? String, ownerEmail == email {
                    // Current user is the owner, proceed with deletion
                    postRef.delete() { error in
                        if let error = error {
                            print("Error removing document: \(error)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                } else {
                    print("Current user is not the owner of the post.")
                }
            } else {
                print("Document does not exist or error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }


    
    // MARK: for testing delete later
    func printCurrentUserDetails() {
            if let user = UserManager.shared.currentUser {
                print("Current User Details:")
                print("User ID: \(user.id ?? "No ID")")
                print("Name: \(user.name)")
                print("Email: \(user.email)")
                print("Profile Image URL: \(user.profileImageURL ?? "No URL")")
                print("Phone: \(user.phone ?? "No Phone")")
                print("Address: \(user.address?.formattedAddress() ?? "No Address")")
            } else {
                print("No current user data available")
            }
        }

}
