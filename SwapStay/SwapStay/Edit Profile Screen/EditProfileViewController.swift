//
//  EditProfileViewController.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class EditProfileViewController: UIViewController {
    let notificationCenter = NotificationCenter.default
    let editProfileView = EditProfileView()
    let db = Firestore.firestore()
    var pickedImage:   UIImage?
    
    var curImage: UIImage?

    
    let storage            = Storage.storage()
    
    override func loadView() {
        view = editProfileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the Back button color to black
        self.navigationController?.navigationBar.tintColor = .black
        
        //MARK: set up on saveButton tapped.
        editProfileView.buttonSave.addTarget(self, action: #selector(onSaveButtonTapped2), for: .touchUpInside)
        editProfileView.buttonEditProfilePhoto.menu = getMenuImagePicker()
        
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
    
    }
    
    //MARK: menu for buttonTakePhoto setup
    func getMenuImagePicker() -> UIMenu{
        var menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera
    func pickUsingCamera() {
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery.
    func pickPhotoFromGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    @objc func onSaveButtonTapped2() {
        
        if let email = Auth.auth().currentUser?.email{
            if let name  = editProfileView.textFieldName.text,
               let phone = editProfileView.textPhoneNumber.text{
                let user = User(name:  name,
                                email: email,
                                phone: phone)
                // If pickedImage is not changged by user, no needs to upload the img
                if pickedImage == curImage{
                    uploadProfilePhotoToStorage(user: user, updateImage: false)
                }else{
                    notificationCenter.post(name: .updateUserProfilePic, object: pickedImage)
                    uploadProfilePhotoToStorage(user: user, updateImage: true)
                }
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
//    @objc func onSaveButtonTapped() {
//        guard let currentUserEmail = UserManager.shared.currentUser?.email else { return }
//
//        // Prepare user data
//        let name = editProfileView.textFieldName.text ?? ""
//        let phoneNum = editProfileView.textPhoneNumber.text ?? ""
//
//        // Handle image upload if a new image is picked
//        if let image = pickedImage {
//            uploadImageAndUpdateUserData(image: image, email: currentUserEmail, name: name, phoneNum: phoneNum, address: address)
//        } else {
//            updateUserFirestoreData(email: currentUserEmail, name: name, phoneNum: phoneNum, profileImageURL: nil, address: address)
//        }
//        
//        // Notify other parts of the app about the update
//        // NotificationCenter.default.post(name: .userProfileUpdated, object: nil)
//
//    }

    // MARK: If profile image was updated
    func uploadImageAndUpdateUserData(image: UIImage, email: String, name: String, phoneNum: String, address: Address) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
                print("Could not get JPEG representation of UIImage")
                return
            }

            // Set a reference to where the image should be stored in Firebase Storage
            let storageRef = Storage.storage().reference().child("user_icons/\(FirestoreUtility.emailToFileName(email: email)).jpg")

            // Upload the image data
            storageRef.putData(imageData, metadata: nil) { metadata, error in
                guard metadata != nil else {
                    // Handle the error
                    print("Error uploading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                // Retrieve the download URL
                storageRef.downloadURL { [weak self] url, error in
                    guard let self = self, let downloadURL = url else {
                        print("Error getting download URL: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }

                    // You now have the URL of the uploaded image
                    // Update the user info in Firebase Firestore with this new image URL
                    self.updateUserFirestoreData(
                        email: email,
                        name: name,
                        phoneNum: phoneNum,
                        profileImageURL: downloadURL.absoluteString,
                        address: address
                    )
                }
            }
        // Notify other parts of the app about the update
        NotificationCenter.default.post(name: .userProfileUpdated, object: nil)
    }

    // MARK: update field other than profile image
    func updateUserFirestoreData(email: String, name: String, phoneNum: String, profileImageURL: String?, address: Address) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(email)
        
        // Prepare the data to update
        var updateData: [String: Any] = [
            "name": name,
            "phoneNum": phoneNum,
            "address": address.toDictionary()
        ]

        // Include the profile image URL if it's available
        if let profileImageURL = profileImageURL {
            updateData["profileImageURL"] = profileImageURL
        }

        // Update data in Firestore
        userRef.updateData(updateData) { [weak self] error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
                
                // Create a new User object with updated information
                var updatedUser = UserManager.shared.currentUser
                updatedUser?.name = name
                updatedUser?.phone = phoneNum
                updatedUser?.address = address
                if let profileImageURL = profileImageURL {
                    updatedUser?.profileImageURL = profileImageURL
                }
                
                // Update the currentUser in UserManager
                UserManager.shared.currentUser = updatedUser
                
                // Post notification to inform other parts of the app about the update
                NotificationCenter.default.post(name: .userProfileUpdated, object: nil)

                // Pop the current view controller (optional, based on your app's flow)
                self?.navigationController?.popViewController(animated: true)
            }
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

//MARK: adopting the required protocols for PHPicker
extension EditProfileViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.editProfileView.buttonEditProfilePhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}

//MARK: adopting required protocols for UIImagePicker...
extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.editProfileView.buttonEditProfilePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}
