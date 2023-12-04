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
    var currentUser:       FirebaseAuth.User?
    var tarBarControllers: [UINavigationController]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // display the start view once the user open the app and is waiting for the response from the server
        let startViewCtroller = StartViewController()
        self.viewControllers  = [startViewCtroller]
        
        // add an observer to get rid of login screen once the user login successfully
        notificationCenter.addObserver(
            self,
            selector: #selector(dismissLogin(notification:)),
            name: .loginSuccessfully,
            object: nil)
        
        // handler for authentication
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            // check the user state
            if user == nil{
                // pop up Login Screen
                let loginViewController = LoginViewController()
                loginViewController.modalPresentationStyle = .fullScreen
                self.present(loginViewController, animated: false, completion: nil)
            }else{
                // set the navigation conttorllers
                self.viewControllers = self.generateNavControllers()
                // add a line above each tab
                self.addLineAboveTab()
            }
        }
    }
    
    // when user login successfully, get rid of login screen
    @objc func dismissLogin(notification: Notification) {
        // dismiss the presented login screen
        self.dismiss(animated: true, completion: nil)
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
}
