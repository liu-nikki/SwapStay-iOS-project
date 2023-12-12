//
//  ShowProfileViewController.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ShowProfileViewController: UIViewController {
    let notificationCenter = NotificationCenter.default
    let showProfileScreen = ShowProfileView()
    let db                = Firestore.firestore()
    var userEdit : User!
    var loadFromEditScreen = false
    
    override func loadView() {
        view = showProfileScreen
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !loadFromEditScreen{
            loadProfileImage2()
        }
        
        loadFromEditScreen = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        //Hiding on-screen Keyboard when tapping outside.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        //MARK: set up on saveButton tapped.
        showProfileScreen.buttonEdit.addTarget(self, action: #selector(onEditButtonTapped), for: .touchUpInside)
        showProfileScreen.buttonEditPassword.addTarget(self, action: #selector(onEditPasswordButtonTapped), for: .touchUpInside)
        showProfileScreen.buttonLogOut.addTarget(self, action: #selector(onLogOutButtonTapped), for: .touchUpInside)
        
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(userProfileUpdated),
                name: .userProfileUpdated,
                object: nil
            )
        
        addProfilePicUpdateFromEditProfileObserver()
        
        printCurrentUserDetails()
    }
    
    func addProfilePicUpdateFromEditProfileObserver(){
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(userProfileUpdatedFromEditScreen),
                name: .updateUserProfilePic,
                object: nil
            )
    }
    
    @objc func userProfileUpdatedFromEditScreen(notification: Notification){
        if let pickedImage = notification.object as? UIImage {
            showProfileScreen.imageProfile.image = pickedImage
            loadFromEditScreen = true
        }
    }
    
    @objc func userProfileUpdated() {
            if let user = UserManager.shared.currentUser {
                updateUIWithUserDetails(user)
                loadProfileImage(user: user)
            }
        }
    
    // Function to update the UI with user details
    func updateUIWithUserDetails(_ user: User) {
        userEdit = user
        showProfileScreen.labelEmail.text    = "Email: \(user.email)"
        showProfileScreen.labelName.text     = "Name: \(user.name)"
        showProfileScreen.labelPhone.text    = "Phone: \(user.phone)"
    }
    
    // Function to load image from URL
    func loadProfileImage(user: User) {
        if let profileImageURLString = user.profileImageURL, let url = URL(string: profileImageURLString) {
            let key = url.absoluteString

            if let cachedImage = UserManager.shared.getCachedImage(forKey: key) {
                self.showProfileScreen.imageProfile.image = cachedImage
            } else {
                URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let data = data, error == nil else {
                        print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
                        return
                    }
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            UserManager.shared.cacheImage(image, forKey: key)
                            self?.showProfileScreen.imageProfile.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
    @objc func onEditButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let editProfileVC = EditProfileViewController()
        
        let editScreen = editProfileVC.editProfileView
        
        if let image =  showProfileScreen.imageProfile.image{
            editScreen.buttonEditProfilePhoto.setImage(image, for: .normal)
        }
        
        
       // editScreen.buttonEditProfilePhoto.imageView?.image = showProfileScreen.imageProfile.image
        editScreen.textFieldName.text                      = userEdit.name
        editScreen.textPhoneNumber.text                    = userEdit.phone
        
        editProfileVC.curImage = editScreen.buttonEditProfilePhoto.imageView?.image
        loadFromEditScreen = true
        
        navigationController?.pushViewController(editProfileVC, animated: true)
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
//        UserManager.shared.currentUser = nil
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
                
                let phone = user.phone
                if !phone.isEmpty{
                    print("Phone: \(phone)")
                }else{
                    print("Phone: Not available")
                }
//                if let phone = user.phone {
//                    print("Phone: \(phone)")
//                } else {
//                    print("Phone: Not available")
//                }
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
