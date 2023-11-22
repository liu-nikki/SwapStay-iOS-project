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
    var currentUser: FirebaseAuth.User?
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
                self.mainScreen.tableViewHouseInfo.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
            }else{
                //MARK: the user is signed in.
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: Observe Firestore database to display the contacts list...
                // all users are friends with other, add all users except the signed in user

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: hide Keyboard on tapping the screen...
        hideKeyboardWhenTappedAround()
        
        
        
//        //MARK: patching table view delegate and data source...
//        mainScreen.tableViewHouseInfo.delegate = self
//        mainScreen.tableViewHouseInfo.dataSource = self
//       
//        //MARK: removing the separator line...
//        mainScreen.tableViewHouseInfo.separatorStyle = .none
    }
    
    //MARK: hide keyboard logic.
    func hideKeyboardWhenTappedAround() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }

}

