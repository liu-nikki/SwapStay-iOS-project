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
    
    let editProfileView = EditProfileView()
    
    override func loadView() {
        view = editProfileView
    }
    
    var currentUser: User?
    
    var pickedImage: UIImage?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirestoreUtility.fetchUser(from: (Auth.auth().currentUser?.email)!) { result in
            switch result {
            case .success(let user):
                // Handle the successful retrieval of the user
                self.currentUser = user
                self.editProfileView.textFieldName.text = self.currentUser?.name ?? ""
                self.editProfileView.textPhoneNumber.text = self.currentUser?.phone ?? ""
                if let profileImageURL = URL(string: (self.currentUser?.profileImageURL)!) {
                    FirestoreUtility.loadImageToButton(from: profileImageURL, into: self.editProfileView.buttonEditProfilePhoto)
                }
                self.editProfileView.textFieldLine1.text = self.currentUser?.address?.line1 ?? ""
                self.editProfileView.textFieldLine2.text = self.currentUser?.address?.line2 ?? ""
                self.editProfileView.textFieldCity.text = self.currentUser?.address?.city ?? ""
                self.editProfileView.textFieldState.text = self.currentUser?.address?.state ?? ""
                self.editProfileView.textFieldZip.text = self.currentUser?.address?.zip ?? ""
            case .failure(let error):
                // Handle any errors
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //MARK: set up on saveButton tapped.
        editProfileView.buttonSave.addTarget(self, action: #selector(onSaveButtonTapped), for: .touchUpInside)
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
    
    @objc func onSaveButtonTapped(){
        //MARK: presenting the RegisterViewController...
        var name: String?
        var phoneNum: String?
        var address: Address?
                
        if let nameText = editProfileView.textFieldName.text,
            let phoneNumText = editProfileView.textPhoneNumber.text,
           let line1Text = editProfileView.textFieldLine1.text,
           let line2Text = editProfileView.textFieldLine2.text,
           let cityText = editProfileView.textFieldCity.text,
           let stateText = editProfileView.textFieldState.text,
           let zipText = editProfileView.textFieldZip.text{
            name = nameText
            phoneNum = phoneNumText
            address = Address(line1: line1Text, line2: line2Text, city: cityText, state: stateText, zip: zipText)
            
            let imageData: Data?
            if let image = self.pickedImage {
                imageData = image.jpegData(compressionQuality: 0.75) // Adjust compression quality as needed
                if let imageData = imageData {
                    // Set a reference to where the image should be stored in Firebase Storage
                    let storageRef = Storage.storage().reference().child("user_icons/\(FirestoreUtility.emailToFileName(email: self.currentUser!.email)).jpg")

                    // Upload the image data
                    storageRef.putData(imageData, metadata: nil) { metadata, error in
                        guard metadata != nil else {
                            // Handle the error
                            print(error?.localizedDescription ?? "Unknown error")
                            return
                        }

                        // Retrieve the download URL
                        storageRef.downloadURL { url, error in
                            if let downloadURL = url {
                                // You now have the URL of the uploaded image
                                // You can store this URL in Firebase Database if needed
                                //MARK: update the user info in the Firebase.
                                let db = Firestore.firestore()
                                let userRef = db.collection("users").document(self.currentUser?.email ?? "")
                                userRef.updateData([
                                    "name": name ?? "",
                                    "phoneNum": phoneNum ?? "",
                                    "profileImageURL": downloadURL.absoluteString,
                                    "address": address?.toDictionary() ?? [:]
                                ]) { err in
                                    if let err = err {
                                        print("Error updating document: \(err)")
                                    } else {
                                        print("Document successfully updated")
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
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
