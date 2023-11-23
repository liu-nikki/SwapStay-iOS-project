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
    
    var currentUser: FirebaseAuth.User?
    
    override func loadView() {
        view = houseListView
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
        
        houseListView.labelWelcome.text = "Welcome \(currentUser?.displayName ?? "Anonymous")!"
        if let profileImageURL = currentUser?.photoURL{
            houseListView.profilePic.setImage(UIImage(named: profileImageURL.absoluteString), for: .normal)
        }
        
        //MARK: set up on profilePicButton tapped.
        houseListView.profilePic.addTarget(self, action: #selector(onProfilePicButtonTapped), for: .touchUpInside)
    }
    
    @objc func onProfilePicButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let showProfileViewController = ShowProfileViewController()
        showProfileViewController.currentUser = currentUser
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
