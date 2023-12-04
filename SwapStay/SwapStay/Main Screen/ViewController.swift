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
    let notificationCenter = NotificationCenter.default
    
    var handleAuth:  AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    let database = Firestore.firestore()
    
    var login = false
    var tarBarControllers: [UINavigationController]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // display the start view once the user open the app and is waiting for the response from the server
        let startViewCtroller = StartViewController()
        self.viewControllers = [startViewCtroller]
        
        // add an observer to get rid of login screen once the user login successfully
        notificationCenter.addObserver(
            self,
            selector: #selector(dismissLogin(notification:)),
            name: .loginSuccessfully,
            object: nil)
      
        
        // handler for authentication
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                print("Pop up Login Screen")
                // pop up Login Screen
                let loginViewController = LoginViewController()
                loginViewController.modalPresentationStyle = .fullScreen
                self.present(loginViewController, animated: false, completion: nil)
                
            }else{
               // self.viewControllers = [tabHouseList, tabProfile, tabChat]
                self.viewControllers = self.generateNavControllers()
                // add a line above each tab
                self.addLineAboveTab()
            }
        }
    }
    
    // when user login successfully, get rid of login screen
    @objc func dismissLogin(notification: Notification) {
        print("DisMiss Login Screen")
        // Dismiss the presented login screen
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateNavControllers() -> [UINavigationController]{
        
        // set up house list tab bar
        let tabHouses = UINavigationController(rootViewController: HouseListViewController())
        let tabHousesBarItem = UITabBarItem(
            title: "Houses",
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.gray),
            selectedImage: UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemTeal)
        )
        tabHouses.tabBarItem = tabHousesBarItem
        tabHouses.title = "Houses"
        
        // set up chats tab bar
        let tabChats = UINavigationController(rootViewController: ChatsViewController())
        let tabChatsBarItem = UITabBarItem(
            title: "Chats",
            image: UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.gray),
            selectedImage: UIImage(systemName: "ellipsis.message")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemTeal)
        )
        tabChats.tabBarItem = tabChatsBarItem
        tabChats.title = "Chats"
        
        // set up profile tab bar
        let tabProfile = UINavigationController(rootViewController: ShowProfileViewController())
        let tabProfileBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.gray),
            selectedImage: UIImage(systemName: "person.crop.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemTeal)
        )
        tabProfile.tabBarItem = tabProfileBarItem
        tabProfile.title = "Profile"
        
        return [tabHouses, tabChats, tabProfile]
    }
    // generate an UINabigationController
    func generateNavController(rootViewController: UIViewController, title: String, imageName: String, selectedImageName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: selectedImageName)
        )
        navigationController.tabBarItem = tabBarItem
        navigationController.title = title
        
        return navigationController
    }
    
    // Add a line above each tab
    func addLineAboveTab(){
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
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

//
//
//class ViewController: UIViewController {
//    
//    let mainScreen = MainScreenView()
//    let postScreen = HouseListView()
//    
//    var houseList = [House]()
//    
//    var handleAuth: AuthStateDidChangeListenerHandle?
//    var currentUser: FirebaseAuth.User?
//    let database = Firestore.firestore()
//    
//    override func loadView() {
//        view = mainScreen
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
//        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
//            
//            if let user = user {
//                // User is signed in
//                self.currentUser = user
//
//                // Print user credentials
//                print("User ID: \(user.uid)")
//                print("Email: \(String(describing: user.email))")
//                print("Display Name: \(String(describing: user.displayName))")
//                print("Photo URL: \(String(describing: user.photoURL))")
//
//                self.postScreen.labelWelcome.text = "Welcome \(user.displayName)!"
//                let houseListViewController = HouseListViewController()
//                
//                self.navigationController?.pushViewController(houseListViewController, animated: true)
//                
//            } else {
//                // No user is signed in
//                self.currentUser = nil
//            }
//            
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //MARK: set up on registerButton tapped.
//        mainScreen.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
//        mainScreen.loginButton.addTarget(self, action: #selector(onLogInButtonTapped), for: .touchUpInside)
//    
//        //MARK: hide Keyboard on tapping the screen.
//        hideKeyboardWhenTappedAround()
//        
//    }
//    
//    //MARK: hide keyboard logic.
//    func hideKeyboardWhenTappedAround() {
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
//        view.addGestureRecognizer(tapRecognizer)
//    }
//    
//    @objc func hideKeyboardOnTap(){
//        view.endEditing(true)
//    }
//    
//    //MARK: Tap to register new user
//    @objc func onRegisterButtonTapped(){
//        //MARK: presenting the RegisterViewController...
//        let registerViewController = RegisterViewController()
//        navigationController?.pushViewController(registerViewController, animated: true)
//    }
//    
//    //MARK: Tap to sign in
//    @objc func onLogInButtonTapped(){
//        guard let email = mainScreen.loginEmailTextField.text, !email.isEmpty,
//              let password = mainScreen.loginPasswordTextField.text, !password.isEmpty else{
//            // Set up alert for empty fields...
//            print("Please enter email and password!")
//            return
//        }
//        
//        signIn(email: email, password: password) { success, message in
//            if success {
//                print(message) // User signed in successfully
//                // Proceed with the app flow
//            } else {
//                self.showAlert(title: "Sign In Error", message: message)
//                // Handle the sign-in failure
//            }
//        }
//
//    }
//
//    func signIn(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
//        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                // Simplified error message
//                completion(false, "Sign-in failed. Please check your credentials and try again.")
//            } else if authResult?.user != nil {
//                completion(true, "User signed in successfully")
//            } else {
//                completion(false, "Sign-in failed. Please try again later.")
//            }
//        }
//    }
//    
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        Auth.auth().removeStateDidChangeListener(handleAuth!)
//    }
//    
//    func showAlert(title: String = "Error", message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//    
//    //once sign in you should land at the post page
//    func getPostDetails(post: House){
//        let houseListViewController = HouseListViewController()
//        houseListViewController.receiver = post
//        navigationController?.pushViewController(houseListViewController, animated: true)
//    }
//
//}
//






//                // Setting up house list tab bar...
//                let tabHouseList = self.generateNavController(rootViewController: HouseListViewController(), title: "House List", imageName: "r.square", selectedImageName: "r.square.fill")
//
//                // Setting up profile tab bar...
//                let tabProfile = self.generateNavController(rootViewController: ShowProfileViewController(), title: "Profile", imageName: "g.square", selectedImageName: "g.square.fill")

                // Setting up chat tab bar...
//                let tabChat = self.generateNavController(rootViewController: ChatViewController(), title: "Blue", imageName: "b.square", selectedImageName: "b.square.fill")
