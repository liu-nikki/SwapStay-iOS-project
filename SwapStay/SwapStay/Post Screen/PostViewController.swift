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
        guard let user = UserManager.shared.currentUser else { return }
        
        let postId = db.collection("posts").document().documentID
        let ownerName = user.name
        let profilePhotoURL = user.profileImageURL ?? ""
        let ownerEmail = user.email
        let startDate = addPostScreen.dateFromButton.text ?? ""
        let endDate = addPostScreen.dateToButton.text ?? ""
        let description = addPostScreen.descriptionTextView.text ?? ""
        let address = addPostScreen.addressTextField.text ?? ""
        let city = addPostScreen.cityTextField.text ?? ""
        let state = addPostScreen.stateTextField.text ?? ""
        let zip = addPostScreen.zipTextField.text ?? ""

        // Create post dictionary
        let postDict: [String: Any] = [
            "postId": postId,
            "ownerName": ownerName,
            "profilePhotoURL": profilePhotoURL,
            "ownerEmail": ownerEmail,
            "startDate": startDate,
            "endDate": endDate,
            "description": description,
            "address": address,
            "city": city,
            "state": state,
            "zip": zip
        ]

        // Save post in user's personal post collection
        db.collection("users").document(ownerEmail).collection("posts").document(postId).setData(postDict) { error in
            if let error = error {
                print("Error saving post to user's collection: \(error)")
            } else {
                print("Post saved to user's collection successfully.")
            }
        }

        // Save post in global post collection
        db.collection("posts").document(postId).setData(postDict) { error in
            if let error = error {
                print("Error saving post to global collection: \(error)")
            } else {
                print("Post saved to global collection successfully.")
            }
        }
        
        // Go back to HouseListScreen
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    func deletePost(postId: String) {
        guard let user = UserManager.shared.currentUser else {
            print("No current user available")
            return
        }

        let email = user.email // Directly use email as it's not optional

        // Fetch the post to check the owner
        let postRef = db.collection("posts").document(postId)
        postRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let ownerEmail = document.data()?["ownerEmail"] as? String, ownerEmail == email {
                    // Current user is the owner, proceed with deletion
                    postRef.delete() { error in
                        if let error = error {
                            print("Error removing document: \(error)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                } else {
                    print("Current user is not the owner of the post.")
                }
            } else {
                print("Document does not exist or error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
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

