//
//  PostViewController.swift
//  SwapStay
//
//  Created by Kaylin Lau on 12/5/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import PhotosUI
import FirebaseStorage

class PostViewController: UIViewController {
    
    let addPostScreen = PostView()
    
    var pickedImage: UIImage?
    
    let db = Firestore.firestore()
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = addPostScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        
        printCurrentUserDetails()
        
        addPostScreen.buttonTakePhoto.menu = getMenuImagePicker()
        
        addPostScreen.postButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
    }
    
    //MARK: menu for buttonTakePhoto setup...
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
    
    // MARK: create a post
    @objc func createPost() {
        guard let user = UserManager.shared.currentUser, let pickedImage = self.pickedImage else { return }

        let uniqueImageFileName = "images/\(UUID().uuidString).jpg"
        let storageRef = Storage.storage().reference().child(uniqueImageFileName)
        if let imageData = pickedImage.jpegData(compressionQuality: 0.75) {
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard error == nil else {
                    print("Failed to upload image: \(error!.localizedDescription)")
                    return
                }
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("Download URL not found")
                        return
                    }
                    self.savePostToFirestore(user: user, imageUrl: downloadURL.absoluteString)
                }
            }
        }
    }

    func savePostToFirestore(user: User, imageUrl: String) {
        let postId = db.collection("posts").document().documentID
        let ownerName = user.name
        let ownerEmail = user.email
        let startDate = addPostScreen.dateFromButton.text ?? ""
        let endDate = addPostScreen.dateToButton.text ?? ""
        let description = addPostScreen.descriptionTextView.text ?? ""
        let address = addPostScreen.addressTextField.text ?? ""
        let city = addPostScreen.cityTextField.text ?? ""
        let state = addPostScreen.stateTextField.text ?? ""
        let zip = addPostScreen.zipTextField.text ?? ""

        let postDict: [String: Any] = [
            "postId": postId,
            "ownerName": ownerName,
            "housePhoto": imageUrl,
            "ownerEmail": ownerEmail,
            "startDate": startDate,
            "endDate": endDate,
            "description": description,
            "address": address,
            "city": city,
            "state": state,
            "zip": zip,
            "timestamp": FieldValue.serverTimestamp()
        ]
        db.collection("users").document(ownerEmail).collection("posts").document(postId).setData(postDict) { error in
            if let error = error {
                print("Error saving post to user's collection: \(error)")
            } else {
                print("Post saved to user's collection successfully.")
            }
        }
        db.collection("posts").document(postId).setData(postDict) { error in
            if let error = error {
                print("Error saving post to global collection: \(error)")
            } else {
                print("Post saved to global collection successfully.")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: for testing delete later
    func printCurrentUserDetails() {
        if let user = UserManager.shared.currentUser {
            print("Current User Details:")
            print("User ID: \(user.id ?? "No ID")")
            print("Name: \(user.name)")
            print("Email: \(user.email)")
            print("Profile Image URL: \(user.profileImageURL ?? "No URL")")
            print("Phone: \(user.phone ?? "No Phone")")
            print("Address: \(user.address?.formattedAddress() ?? "No Address")")
        } else {
            print("No current user data available")
        }
    }

}


//MARK: adopting the required protocols for PHPicker
extension PostViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.addPostScreen.buttonTakePhoto.setImage(
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
extension PostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.addPostScreen.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}

