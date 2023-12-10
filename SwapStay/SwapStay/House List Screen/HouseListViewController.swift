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
        
        
        // Listen to user profile updates
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loadUserInfo),
            name: .userProfileUpdated,
            object: nil
        )
        
        // Table view delegate and date source
        houseListScreen.tableViewHouses.delegate       = self
        houseListScreen.tableViewHouses.dataSource     = self
        houseListScreen.tableViewHouses.separatorStyle = .none
        
        //fetch all posts from the datastore
        fetchPosts()
    }
    
    
    
    @objc func loadUserInfo() {
        if let user = UserManager.shared.currentUser {
            // Update the welcome label with the user's name
            houseListScreen.labelWelcome.text = "Welcome \(user.name)!"

            // Update the profile picture
            if let profileImageURLString = user.profileImageURL,
               let url = URL(string: profileImageURLString) {
                let key = url.absoluteString

                // Check for cached image
                if let cachedImage = UserManager.shared.getCachedImage(forKey: key) {
                    houseListScreen.profilePic.setImage(cachedImage, for: .normal)
                } else {
                    // If no cached image, download and cache
                    URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                        guard let data = data, error == nil else {
                            print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
                            return
                        }
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                UserManager.shared.cacheImage(image, forKey: key)
                                self?.houseListScreen.profilePic.setImage(image, for: .normal)
                            }
                        }
                    }.resume()
                }
            } else {
                // Set default image if no profile URL
                houseListScreen.profilePic.setImage(UIImage(named: "AppDefaultProfiePic"), for: .normal)
            }
        } else {
            // Reset to default values if no user is logged in
            houseListScreen.labelWelcome.text = "Welcome User!"
            houseListScreen.profilePic.setImage(UIImage(named: "AppDefaultProfiePic"), for: .normal)
        }
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
    
    func fetchPosts() {
        db.collection("posts").getDocuments { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self?.houseList.removeAll()
                for document in querySnapshot!.documents {
                    do {
                        let post = try document.data(as: House.self)
                        self?.houseList.append(post)
                    } catch {
                        print("Error decoding post: \(error)")
                    }
                }
                DispatchQueue.main.async {
                    self?.printFetchedPosts()
                    self?.houseListScreen.tableViewHouses.reloadData()
                }
            }
        }
    }

    // MARK: - Testing function to print fetched posts
        func printFetchedPosts() {
            for post in houseList {
                print("Fetched post: \(post)")
            }
            print("Total posts fetched: \(houseList.count)")
        }
    
}
