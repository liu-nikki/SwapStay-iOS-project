//
//  ShowProfileViewController.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit
import FirebaseAuth

class ShowProfileViewController: UIViewController {
    
    let showProfileView = ShowProfileView()
    
    override func loadView() {
        view = showProfileView
    }
    
//    var receivedUser: User?
    var currentUser: FirebaseAuth.User?

    override func viewDidLoad() {
        super.viewDidLoad()

        showProfileView.labelUsername.text = "Email: \(currentUser?.email ?? "")"
        showProfileView.labelName.text = "Name: \(currentUser?.displayName ?? "")"
//        showProfileView.labelPassword.text = currentUser.map({ _ in "********" })
        showProfileView.labelPhone.text = "Phone: \(currentUser?.phoneNumber ?? "")"
        if let profileImageURL = currentUser?.photoURL{
            showProfileView.imageProfile.image = UIImage(named: profileImageURL.absoluteString)
        }
//        showProfileView.imageProfile.image = UIImage(named: receivedUser?.profileImageURL ?? "")
        
        //Hiding on-screen Keyboard when tapping outside.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        //MARK: set up on saveButton tapped.
        showProfileView.buttonEdit.addTarget(self, action: #selector(onEditButtonTapped), for: .touchUpInside)
        showProfileView.buttonLogOut.addTarget(self, action: #selector(onLogOutButtonTapped), for: .touchUpInside)
        
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
        
    }
    
    @objc func onEditButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.currentUser = currentUser
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    @objc func onLogOutButtonTapped() {
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
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
