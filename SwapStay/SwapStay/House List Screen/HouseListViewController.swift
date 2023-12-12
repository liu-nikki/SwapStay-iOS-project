//
//  HouseListViewController.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class HouseListViewController: UIViewController {
    let notificationCenter = NotificationCenter.default // Used to redirect to profile screen
    let houseListScreen    = HouseListView()            // House List Screen View
    let db                 = Firestore.firestore()      // Get database reference
    let storage            = Storage.storage()          // Get storage reference
    var houseList          = [House]()                  // A List to store posts
    
    var postsListener: ListenerRegistration?
    
    override func loadView() {
        view = houseListScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Load user infomation, including name and profile photo
        loadUserInfo()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable back navigation
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        // Set background color to white
        view.backgroundColor = .white
        
        
        //MARK: set up on profilePicButton tapped.
        houseListScreen.profilePic.addTarget(self, action: #selector(onProfilePicButtonTapped), for: .touchUpInside)
        
        houseListScreen.buttonPost.addTarget(self, action: #selector(onPostButtonTapped), for: .touchUpInside)
        
        
        // Table view delegate and date source
        houseListScreen.tableViewHouses.delegate       = self
        houseListScreen.tableViewHouses.dataSource     = self
        houseListScreen.tableViewHouses.separatorStyle = .none
        
        //fetch all posts from the datastore
        addPostUpdateListner()
    }
    
    @objc func onProfilePicButtonTapped(){
        // Redirect to user profile view
        notificationCenter.post(name: .userProfilePicTapped, object: "")
    }
    
    // MARK: the button to create a new post
    @objc func onPostButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }

    // MARK: - Testing function to print fetched posts
    func printFetchedPosts() {
        for post in houseList {
            print("Fetched post: \(post)")
        }
        print("Total posts fetched: \(houseList.count)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        postsListener?.remove()
    }
}
