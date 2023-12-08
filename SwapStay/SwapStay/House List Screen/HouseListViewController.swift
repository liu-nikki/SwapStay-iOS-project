//
//  HouseListViewController.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class HouseListViewController: UIViewController {
    
    let houseListScreen = HouseListView()
//    var currentUser: FirebaseAuth.User?
    // Get a reference to the storage service using the default Firebase App
    let storage         = Storage.storage()
    var houseList       =  [House]()
    
    override func loadView() {
        view = houseListScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Load user infomation, including name and profile photo
        loadUserInfo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable back navigation
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        // Set background color to white
        view.backgroundColor = .white
        
        //MARK: hide Keyboard on tapping the screen.
        hideKeyboardWhenTappedAround()
        
        //MARK: set up on profilePicButton tapped.
        houseListScreen.profilePic.addTarget(self, action: #selector(onProfilePicButtonTapped), for: .touchUpInside)
        
        houseListScreen.buttonPost.addTarget(self, action: #selector(onPostButtonTapped), for: .touchUpInside)
        
        houseListScreen.buttonPost2.addTarget(self, action: #selector(onPost2ButtonTapped), for: .touchUpInside)
        
        // Listen to user profile updates
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loadUserInfo),
            name: .userProfileUpdated,
            object: nil
        )
        
        // Table view delegate and date source
        houseListScreen.tableViewHouses.delegate       = self
        houseListScreen.tableViewHouses.dataSource     = self
        houseListScreen.tableViewHouses.separatorStyle = .none
    }
    
    @objc func loadUserInfo() {
        if let user = UserManager.shared.currentUser {
            // Update the welcome label with the user's name
            houseListScreen.labelWelcome.text = "Welcome \(user.name)!"

            // Update the profile picture
            if let profileImageURLString = user.profileImageURL,
               let url = URL(string: profileImageURLString) {
                let key = url.absoluteString

                // Check for cached image
                if let cachedImage = UserManager.shared.getCachedImage(forKey: key) {
                    houseListScreen.profilePic.setImage(cachedImage, for: .normal)
                } else {
                    // If no cached image, download and cache
                    URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                        guard let data = data, error == nil else {
                            print("Error downloading image: \(error?.localizedDescription ?? "unknown error")")
                            return
                        }
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                UserManager.shared.cacheImage(image, forKey: key)
                                self?.houseListScreen.profilePic.setImage(image, for: .normal)
                            }
                        }
                    }.resume()
                }
            } else {
                // Set default image if no profile URL
                houseListScreen.profilePic.setImage(UIImage(named: "AppDefaultProfiePic"), for: .normal)
            }
        } else {
            // Reset to default values if no user is logged in
            houseListScreen.labelWelcome.text = "Welcome User!"
            houseListScreen.profilePic.setImage(UIImage(named: "AppDefaultProfiePic"), for: .normal)
        }
    }
    
    @objc func onProfilePicButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let showProfileViewController = ShowProfileViewController()
        navigationController?.pushViewController(showProfileViewController, animated: true)
    }
    
    //MARK: hide keyboard logic.
    func hideKeyboardWhenTappedAround() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onPostButtonTapped(){
        //MARK: presenting the RegisterViewController...
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc func onPost2ButtonTapped(){
        let house = House(houseImg: Data(), ownerName: "None", ownerEmail: "None", post: "None", address: "None", dateFrom: Date(), dateTo: Date())
        houseList.append(house)
        houseListScreen.tableViewHouses.reloadData()
    }
    
    @objc func hideKeyboardOnTap(){
        view.endEditing(true)
    }
}


// works as expected

//let imgURLString = "https://firebasestorage.googleapis.com:443/v0/b/swapstay-ios.appspot.com/o/temp_user_icons%2F123@email.com.jpg?alt=media&token=b954371b-2ea7-4449-ac29-cdb2b240f656"
//let imageRef = storage.reference(forURL: imgURLString)
//imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
//  if let error = error {
//    // Uh-oh, an error occurred!
//      print("ERROR---->")
//      print(error)
//  } else {
//    let image = UIImage(data: data!)
//      if let unwrappedImage = image{
//          self.imageList.append(unwrappedImage)
//      }
//
//    print("Set sccussefully!")
//  }
//}
//houseDetailsViewController.houseDetailScreen.imageHouse.image = imageList[0]
