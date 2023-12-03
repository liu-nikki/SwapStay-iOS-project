//
//  ViewController.swift
//  SwapStay
//
//  Created by Nikki Liu on 11/18/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    let postScreen = HouseListView()
    
    var houseList = [House]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    let database = Firestore.firestore()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            
            if let user = user {
                // User is signed in
                self.currentUser = user

                // Print user credentials
                print("User ID: \(user.uid)")
                print("Email: \(String(describing: user.email))")
                print("Display Name: \(String(describing: user.displayName))")
                print("Photo URL: \(String(describing: user.photoURL))")

                self.postScreen.labelWelcome.text = "Welcome \(user.displayName)!"
                let houseListViewController = HouseListViewController()
                
                self.navigationController?.pushViewController(houseListViewController, animated: true)
                
            } else {
                // No user is signed in
                self.currentUser = nil
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: set up on registerButton tapped.
        mainScreen.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
        mainScreen.loginButton.addTarget(self, action: #selector(onLogInButtonTapped), for: .touchUpInside)
    
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
        
    }
    
    //MARK: hide keyboard logic.
    func hideKeyboardWhenTappedAround() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    //MARK: Tap to register new user
    @objc func onRegisterButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    //MARK: Tap to sign in
    @objc func onLogInButtonTapped(){
        guard let email = mainScreen.loginEmailTextField.text, !email.isEmpty,
              let password = mainScreen.loginPasswordTextField.text, !password.isEmpty else{
            // Set up alert for empty fields...
            print("Please enter email and password!")
            return
        }
        
        signIn(email: email, password: password) { success, message in
            if success {
                print(message) // User signed in successfully
                // Proceed with the app flow
            } else {
                self.showAlert(title: "Sign In Error", message: message)
                // Handle the sign-in failure
            }
        }

    }

    func signIn(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Simplified error message
                completion(false, "Sign-in failed. Please check your credentials and try again.")
            } else if authResult?.user != nil {
                completion(true, "User signed in successfully")
            } else {
                completion(false, "Sign-in failed. Please try again later.")
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func showAlert(title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //once sign in you should land at the post page
    func getPostDetails(post: House){
        let houseListViewController = HouseListViewController()
        houseListViewController.receiver = post
        navigationController?.pushViewController(houseListViewController, animated: true)
    }

}

