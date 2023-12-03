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
    
    var currentUser: FirebaseAuth.User?

    
    override func loadView() {
        view = houseListView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        FirestoreUtility.fetchUser(from: (Auth.auth().currentUser?.email)!) { result in
//            switch result {
//            case .success(let user):
//                // Handle the successful retrieval of the user
////                self.currentUser = user
//                self.houseListView.labelWelcome.text = "Welcome \(user.name)!"
//                if let profileImageURL = URL(string: (self.currentUser?.profileImageURL)!) {
//                    FirestoreUtility.loadImageToButton(from: profileImageURL, into: self.houseListView.profilePic)
//                }
//            case .failure(let error):
//                // Handle any errors
//                print(error)
//            }
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // Disable back navigation
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        // set background color to white
        view.backgroundColor = .white
        
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
        
        //MARK: set up on profilePicButton tapped.
        houseListView.profilePic.addTarget(self, action: #selector(onProfilePicButtonTapped), for: .touchUpInside)
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
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
    
                                        
}
