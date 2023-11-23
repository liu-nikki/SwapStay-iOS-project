//
//  EditProfileViewController.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class EditProfileViewController: UIViewController {
    
    let editProfileView = EditProfileView()
    
    override func loadView() {
        view = editProfileView
    }
    
    var currentUser: FirebaseAuth.User?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileView.textFieldName.text = currentUser?.displayName ?? ""
        editProfileView.textPhoneNumber.text = currentUser?.phoneNumber ?? ""
        if let profileImageURL = currentUser?.photoURL{
            editProfileView.buttonEditProfilePhoto.setImage(UIImage(named: profileImageURL.absoluteString), for: .normal)
        }

        //MARK: set up on saveButton tapped.
        editProfileView.buttonSave.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
        
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
        
        
    }
    
    @objc func onSaveButtonTapped(){
        //MARK: presenting the RegisterViewController...
        var name: String?
        var phoneNum: String?
        var profileImageURL: URL?
        
        if let nameText = editProfileView.textFieldName.text,
            let phoneNumText = editProfileView.textPhoneNumber.text,
            let profileImageURLText = editProfileView.buttonEditProfilePhoto.currentImage?.accessibilityIdentifier{
            name = nameText
            phoneNum = phoneNumText
            profileImageURL = URL(string: profileImageURLText)
            
            //MARK: update the user info in the Firebase.
        }
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
