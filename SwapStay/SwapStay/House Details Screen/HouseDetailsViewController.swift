//
//  HouseDetailViewController.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/4/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HouseDetailsViewController: UIViewController {
    
    let houseDetailScreen = HouseDetailsView()

    var post: House!
    let db                 = Firestore.firestore()      // Get database reference
    
    
    override func loadView() {
        view = houseDetailScreen
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func updatePostInfo(post: House){
        houseDetailScreen.labelOwner.text = "\(post.ownerName)'s Place"
        houseDetailScreen.labelPost.text  = post.description
        
    }
    
    func configureButton(post: House) {
        // Check if the current user is the post owner
        if let currentUserEmail = Auth.auth().currentUser?.email, currentUserEmail == post.ownerEmail {
            // Current user is the post owner, configure as Delete Post button
            houseDetailScreen.buttonBook.setTitle("Delete Post", for: .normal)
            houseDetailScreen.buttonBook.removeTarget(nil, action: nil, for: .allEvents)
            houseDetailScreen.buttonBook.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
        } else {
            // Current user is not the post owner, configure as Book Chat button
            houseDetailScreen.buttonBook.setTitle("Book Room", for: .normal)
            houseDetailScreen.buttonBook.removeTarget(nil, action: nil, for: .allEvents)
            houseDetailScreen.buttonBook.addTarget(self, action: #selector(bookRoomTapped), for: .touchUpInside)
        }
    }
    
    // MARK: if the poster is the same as current user, button to book is change to option to delete
    @objc func deletePost() {
        guard let user = Auth.auth().currentUser, let userEmail = user.email, let postId = post?.postId else {
            print("Current user or post ID not available")
            return
        }

        // Delete from user's personal post collection
        db.collection("users").document(userEmail).collection("posts").document(postId).delete { error in
            if let error = error {
                print("Error deleting post from user's collection: \(error)")
            } else {
                print("Post deleted from user's collection successfully.")
            }
        }

        // Delete from global posts collection
        db.collection("posts").document(postId).delete { error in
            if let error = error {
                print("Error deleting post from global collection: \(error)")
            } else {
                print("Post deleted from global collection successfully.")
                // Pop back to the previous view controller after successful deletion
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    // MARK: Else choose book room button to chat with poster
    @objc func bookRoomTapped() {

        // Assuming 'post' is an instance of 'House' with all required data
        let chat = Chat(ChatId: "placeholder id", name: post.ownerName, email: post.ownerEmail, address: post.address, date: Date())
        let messagesVC = MessagesViewController()
        messagesVC.receiver = chat
        // Swtich to chat screen
        NotificationCenter.default.post(name: .switchToChatsTab, object: messagesVC)
        // Move back to house list screen
        self.navigationController?.popViewController(animated: false)
    }


}
