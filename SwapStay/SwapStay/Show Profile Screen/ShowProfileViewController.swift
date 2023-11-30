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
        showProfileView.buttonEditPassword.addTarget(self, action: #selector(onEditPasswordButtonTapped), for: .touchUpInside)
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
    
    @objc func onEditPasswordButtonTapped(){
        //MARK: set up UIAlert to change the password in firestore
        let editPasswordAlert = UIAlertController(
            title: "Change Password",
            message: "Enter your current and new password",
            preferredStyle: .alert)
        
        //MARK: setting up email textField in the alert...
        editPasswordAlert.addTextField{ textField in
            textField.placeholder = "Enter current password"
            textField.contentMode = .center
            textField.isSecureTextEntry = true
        }
        
        //MARK: setting up password textField in the alert.
        editPasswordAlert.addTextField{ textField in
            textField.placeholder = "Enter new password"
            textField.contentMode = .center
            textField.isSecureTextEntry = true
        }
        
        //MARK: confirm new password textField in the alert.
        editPasswordAlert.addTextField{ textField in
            textField.placeholder = "Confirm new password"
            textField.contentMode = .center
            textField.isSecureTextEntry = true
        }
        
        //MARK: Cancel Action.
//        let signInAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_) in
//            if let email = editPasswordAlert.textFields![0].text,
//               let password = editPasswordAlert.textFields![1].text{
//                //MARK: sign-in logic for Firebase...
//                self.signInToFirebase(email: email, password: password)
//            }
//        })
        
        //MARK: Register Action...
        let changePasswordAction = UIAlertAction(title: "Confirm", style: .default, handler: {(_) in
            //MARK: logic to open the register screen...
            if let currentPassword = editPasswordAlert.textFields![0].text,
               let newPassword = editPasswordAlert.textFields![1].text,
               let confirmNewPassword = editPasswordAlert.textFields![2].text {
                if (newPassword != confirmNewPassword) {
                    self.showAlert(title: "Error", message: "New password and confirm password do not match!")
                } else {
                    let user = Auth.auth().currentUser
                    var credential: AuthCredential

                    // Prompt the user to re-enter their email and password
                    let email = self.currentUser?.email  // User's email
                    let password = currentPassword  // User's current password

                    credential = EmailAuthProvider.credential(withEmail: email!, password: password)
                    user?.reauthenticate(with: credential) { result, error in
                        if error != nil {
                            // An error happened.
                            self.showAlert(title: "Error", message: "Please check your current password!")
                        } else {
                            // User re-authenticated. Now, update the password.
                            user?.updatePassword(to: newPassword) { error in
                                // Handle password update
                                self.showAlert(title: "Success", message: "Password updated successfully!")
                            }
                        }
                    }
                }
            }
                
                
        })
        
        //MARK: action buttons...
        editPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        editPasswordAlert.addAction(changePasswordAction)
        
        self.present(editPasswordAlert, animated: true, completion: {() in
            //MARK: hide the alerton tap outside...
            editPasswordAlert.view.superview?.isUserInteractionEnabled = true
            editPasswordAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
        
    }
    
    @objc func onTapOutsideAlert(){
        self.dismiss(animated: true)
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
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
