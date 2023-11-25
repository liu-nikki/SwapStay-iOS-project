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
    
    override func loadView() {
        view = mainScreen
    }
    
    var houseList = [House]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: User?
    let database = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in.
                self.currentUser = nil
                //self.mainScreen.labelText.text = "Please sign in to see the messages!"
                //MARK: Reset tableView.
                self.houseList.removeAll()
//                self.mainScreen.tableViewHouseInfo.reloadData()
                
                //MARK: Sign in bar button...
//                self.setupRightBarButton(isLoggedin: false)
            }else{
                //MARK: the user is signed in.
//                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                self.mainScreen.loginEmailTextField.text = ""
                self.mainScreen.loginPasswordTextField.text = ""
                
                //MARK: Logout bar button...
//                self.setupRightBarButton(isLoggedin: true)
                let houstListViewController = HouseListViewController()
                self.navigationController?.pushViewController(houstListViewController, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        loginEmailTextField = UITextField()
//        loginPasswordTextField = UITextField()
//
//        // Add text fields to the view
//        view.addSubview(loginEmailTextField)
//        view.addSubview(loginPasswordTextField)
        
        //MARK: set up on registerButton tapped.
        mainScreen.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
        mainScreen.loginButton.addTarget(self, action: #selector(onLogInButtonTapped), for: .touchUpInside)
        
        
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
        
        
//        //MARK: patching table view delegate and data source...
//        mainScreen.tableViewHouseInfo.delegate = self
//        mainScreen.tableViewHouseInfo.dataSource = self
//
//        //MARK: removing the separator line...
//        mainScreen.tableViewHouseInfo.separatorStyle = .none
    }
    
    
    
    @objc func onRegisterButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    //MARK: hide keyboard logic.
    func hideKeyboardWhenTappedAround() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    @objc func onLogInButtonTapped(){
        guard let email = mainScreen.loginEmailTextField.text, !email.isEmpty,
              let password = mainScreen.loginPasswordTextField.text, !password.isEmpty else{
            // Set up alert for empty fields...
            print("Please enter email and password!")
            return
        }
        signInToFirebase(email: email, password: password)
    }
    
    func signInToFirebase(email: String, password: String){
        //MARK: can you display progress indicator here?
        //MARK: authenticating the user...
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                //MARK: user authenticated...
                //MARK: can you hide the progress indicator here?
            }else{
                //MARK: alert that no user found or password wrong...
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }

}

