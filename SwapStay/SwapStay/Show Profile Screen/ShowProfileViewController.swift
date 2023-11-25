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
    var currentUser: User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirestoreUtility.fetchUser(from: (Auth.auth().currentUser?.email)!) { result in
            switch result {
            case .success(let user):
                // Handle the successful retrieval of the user
                self.currentUser = user
                self.showProfileView.labelUsername.text = "Email: \(self.currentUser?.email ?? "")"
                self.showProfileView.labelName.text = "Name: \(self.currentUser?.name ?? "")"
        //        showProfileView.labelPassword.text = currentUser.map({ _ in "********" })
                self.showProfileView.labelPhone.text = "Phone: \(self.currentUser?.phone ?? "")"
                self.showProfileView.labelAddress.text = "Address: \n\(self.currentUser?.address?.formattedAddress() ?? "")"
                
                if let profileImageURL = URL(string: (self.currentUser?.profileImageURL)!) {
                    FirestoreUtility.loadImageToImage(from: profileImageURL, into: self.showProfileView.imageProfile)
                }
            case .failure(let error):
                // Handle any errors
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
