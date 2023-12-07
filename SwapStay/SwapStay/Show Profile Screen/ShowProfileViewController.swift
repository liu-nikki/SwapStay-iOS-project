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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch the current user data from UserManager and update UI
        if let user = UserManager.shared.currentUser {
            updateUIWithUserDetails(user)
            if let profileImageURLString = user.profileImageURL,
               let url = URL(string: profileImageURLString) {
                loadImage(from: url)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        //Hiding on-screen Keyboard when tapping outside.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        //MARK: set up on saveButton tapped.
        showProfileView.buttonEdit.addTarget(self, action: #selector(onEditButtonTapped), for: .touchUpInside)
        showProfileView.buttonEditPassword.addTarget(self, action: #selector(onEditPasswordButtonTapped), for: .touchUpInside)
        showProfileView.buttonLogOut.addTarget(self, action: #selector(onLogOutButtonTapped), for: .touchUpInside)
        
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(userProfileUpdated),
                name: .userProfileUpdated,
                object: nil
            )
        
        printCurrentUserDetails()
    }
    
    @objc func userProfileUpdated() {
        if let user = UserManager.shared.currentUser {
            updateUIWithUserDetails(user)
            if let profileImageURLString = user.profileImageURL,
               let url = URL(string: profileImageURLString) {
                loadImage(from: url)
            }
        }
    }
    
    // Function to update the UI with user details
    func updateUIWithUserDetails(_ user: User) {
        showProfileView.labelUsername.text = "Email: \(user.email)"
        showProfileView.labelName.text = "Name: \(user.name)"
        showProfileView.labelPhone.text = "Phone: \(user.phone ?? "Not available")"
        showProfileView.labelAddress.text = "Address: \n\(user.address?.formattedAddress() ?? "Not available")"
    }
    
    // Function to load image from URL
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            DispatchQueue.main.async { // Ensure UI updates are on main thread
                if let image = UIImage(data: data) {
                    self.showProfileView.imageProfile.image = image
                }
            }
        }.resume()
    }
    
    @objc func onEditButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let editProfileViewController = EditProfileViewController()
//        editProfileViewController.UserManager.shared.currentUser = UserManager.shared.currentUser
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
        
        //MARK: Register Action...
        let changePasswordAction = UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            if let currentPassword = editPasswordAlert.textFields?[0].text,
               let newPassword = editPasswordAlert.textFields?[1].text,
               let confirmNewPassword = editPasswordAlert.textFields?[2].text {
                
                if newPassword != confirmNewPassword {
                    self.showAlert(title: "Error", message: "New password and confirm password do not match!")
                    return
                }
                
                guard let user = Auth.auth().currentUser,
                      let email = UserManager.shared.currentUser?.email else {
                    print("Error: Current user or email not found.")
                    return
                }

                // Using EmailAuthProvider to create the credential
                let credential: AuthCredential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)

                user.reauthenticate(with: credential) { _, error in
                    if let error = error {
                        // An error happened during re-authentication.
                        self.showAlert(title: "Error", message: "Re-authentication failed: \(error.localizedDescription)")
                    } else {
                        // User re-authenticated. Now, update the password.
                        user.updatePassword(to: newPassword) { error in
                            if let error = error {
                                self.showAlert(title: "Error", message: "Password update failed: \(error.localizedDescription)")
                            } else {
                                // Handle password update success
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
    
    @objc func onTapOutsideAlert(){
        self.dismiss(animated: true)
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
    
    func printCurrentUserDetails() {
            if let user = UserManager.shared.currentUser {
                print("User Details:")
                print("Name: \(user.name)")
                print("Email: \(user.email)")
                if let profileImageURL = user.profileImageURL {
                    print("Profile Image URL: \(profileImageURL)")
                } else {
                    print("Profile Image URL: Not available")
                }
                if let phone = user.phone {
                    print("Phone: \(phone)")
                } else {
                    print("Phone: Not available")
                }
                if let address = user.address {
                    print("Address: \(address.formattedAddress())")
                } else {
                    print("Address: Not available")
                }
            } else {
                print("currentUser is nil")
            }
        }
    
}
