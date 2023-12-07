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

class PostViewController: UIViewController {
    
    var currentUser:FirebaseAuth.User?
    
    let addPostScreen = PostView()
    
    let db = Firestore.firestore()
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = addPostScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
