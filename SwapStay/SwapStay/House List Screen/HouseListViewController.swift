//
//  HouseListViewController.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit
import FirebaseAuth

class HouseListViewController: UIViewController {
    
    let houseListView = HouseListView()
    var receiver: House!
    
//    var currentUser: FirebaseAuth.User?

    
    override func loadView() {
        view = houseListView
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
        
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
        
        //MARK: set up on profilePicButton tapped.
        houseListView.profilePic.addTarget(self, action: #selector(onProfilePicButtonTapped), for: .touchUpInside)
        
        houseListView.buttonPost.addTarget(self, action: #selector(onPostButtonTapped), for: .touchUpInside)
        
        // Listen to user profile updates
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loadUserInfo),
            name: .userProfileUpdated,
            object: nil
        )
    }
    
    @objc func loadUserInfo() {
        if let user = UserManager.shared.currentUser {
            // Update the welcome label with the user's name
            houseListView.labelWelcome.text = "Welcome \(user.name)!"

            // Update the profile picture
            if let profileImageURLString = user.profileImageURL,
               let url = URL(string: profileImageURLString) {
                let key = url.absoluteString

                // Check for cached image
                if let cachedImage = UserManager.shared.getCachedImage(forKey: key) {
                    houseListView.profilePic.setImage(cachedImage, for: .normal)
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
                                self?.houseListView.profilePic.setImage(image, for: .normal)
                            }
                        }
                    }.resume()
                }
            } else {
                // Set default image if no profile URL
                houseListView.profilePic.setImage(UIImage(named: "AppDefaultProfiePic"), for: .normal)
            }
        } else {
            // Reset to default values if no user is logged in
            houseListView.labelWelcome.text = "Welcome User!"
            houseListView.profilePic.setImage(UIImage(named: "AppDefaultProfiePic"), for: .normal)
        }
    }
    
    @objc func onProfilePicButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let showProfileViewController = ShowProfileViewController()
        navigationController?.pushViewController(showProfileViewController, animated: true)
    }
    
    //MARK: hide keyboard logic.
    func hideKeyboardWhenTappedAround() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onPostButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}
