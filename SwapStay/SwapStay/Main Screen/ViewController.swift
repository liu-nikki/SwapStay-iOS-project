//
//  ViewController.swift
//  SwapStay
//
//  Created by Nikki Liu on 11/18/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UITabBarController, UITabBarControllerDelegate {
    // used to add observer
    let notificationCenter = NotificationCenter.default
    let database           = Firestore.firestore()
    
    var handleAuth:        AuthStateDidChangeListenerHandle?
    var currentUser:       User?
    var tarBarControllers: [UINavigationController]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // display the start view once the user open the app and is waiting for the response from the server
        let startViewCtroller = StartViewController()
        self.viewControllers  = [startViewCtroller]
        
        // Add an observer to get rid of login screen once the user login successfully
        addDissMissLoginScreenObserver()
        
        // Add an observer to redirect to profile screen once the user tap profile picture
        addProfilePicTappedObserver()
        
        // Add an observer to redirect to chats screen once the user tap book chat button on house details screen
        addSwitchToChatObserver()
        
        // handler for authentication
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            // if user is signed in
            if let user = user {
                self.addLineAboveTab()
                if let email = Auth.auth().currentUser?.email {
                    self.fetchUserDetails(email: email)
                        }
                self.viewControllers = self.generateNavControllers()
            } else {
                let loginViewController = LoginViewController()
                let navigationController = UINavigationController(rootViewController: loginViewController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: false, completion: nil)
            }
        }
    }
    
    
    func generateNavControllers() -> [UINavigationController]{
        // set up house list tab bar
        let tabHouses        = UINavigationController(rootViewController: HouseListViewController())
        let tabHousesBarItem = UITabBarItem(
            title: "Houses",
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.gray),
            selectedImage: UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemTeal)
        )
        tabHouses.tabBarItem = tabHousesBarItem
        tabHouses.title      = "Houses"
        
        // set up chats tab bar
        let tabChats        = UINavigationController(rootViewController: ChatsViewController())
        let tabChatsBarItem = UITabBarItem(
            title: "Chats",
            image: UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.gray),
            selectedImage: UIImage(systemName: "ellipsis.message")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemTeal)
        )
        tabChats.tabBarItem = tabChatsBarItem
        tabChats.title      = "Chats"
        
        // set up profile tab bar
        let tabProfile        = UINavigationController(rootViewController: ShowProfileViewController())
        let tabProfileBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.gray),
            selectedImage: UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemTeal)
        )
        tabProfile.tabBarItem = tabProfileBarItem
        tabProfile.title      = "Profile"
        
        return [tabHouses, tabChats, tabProfile]
    }
    
    // add a line above each tab
    func addLineAboveTab(){
        tabBar.shadowImage       = UIImage()
        tabBar.backgroundImage   = UIImage()
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observe when the app becomes active, detects for currently signed in user
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func appDidBecomeActive() {
        // Fetch user details when the app becomes active
        if let email = Auth.auth().currentUser?.email {
            fetchUserDetails(email: email)
        }
    }
    
    func fetchUserDetails(email: String) {
        FirestoreUtility.fetchUser(from: email) { result in
            switch result {
            case .success(let user):
                UserManager.shared.currentUser = user
                // Notify other parts of the app that the user info is updated
                NotificationCenter.default.post(name: .userProfileUpdated, object: nil)
                self.printCurrentUserDetails()
            case .failure(let error):
                print("Error fetching user: \(error)")
                // Handle error appropriately
            }
        }
    }
    
    
    
    //can be deleted later, checking currentuser detail
    func printCurrentUserDetails() {
        if let user = UserManager.shared.currentUser {
            print("THE CURRENT USER IS SIGNED IN")
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
