//
//  LoginViewController.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/3/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    let notificationCenter = NotificationCenter.default
    let loginScreen        = LoginScreenView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser != nil{
            // notify the screen to update and will redirect to TabBarControllers
            notificationCenter.post(name: .loginSuccessfully, object: "")
        }
        

    }
    override func loadView() {
        view = loginScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add login button action
        loginScreen.loginButton.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
        loginScreen.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
        
        // add an observer to get rid of login screen once the user login successfully
        notificationCenter.addObserver(
            self,
            selector: #selector(dismissRegisterScreen(notification:)),
            name: .registerSuccessfully,
            object: nil)
    }
    
    @objc func onButtonLoginTapped(){
        guard let email    = loginScreen.loginEmailTextField.text, !email.isEmpty,
              let password = loginScreen.loginPasswordTextField.text, !password.isEmpty else{
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
                // notify the screen to update and will redirect to TabBarControllers
                self.notificationCenter.post(name: .loginSuccessfully, object: "")
            } else {
                completion(false, "Sign-in failed. Please try again later.")
            }
        }
    }
    
    func showAlert(title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func onRegisterButtonTapped(){
        print("onRegisterButtonTapped")
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
//        registerViewController.modalPresentationStyle = .fullScreen
//        self.present(registerViewController, animated: true, completion: nil)
    }
    
    @objc func dismissRegisterScreen(notification: Notification){
        print("DisMiss Register Screen")
        // Dismiss the presented register screen
        self.dismiss(animated: true, completion: nil)
    }
}
