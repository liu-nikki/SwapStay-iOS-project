//
//  HouseDetailViewController.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/4/23.
//

import UIKit

class HouseDetailsViewController: UIViewController {
    
    let houseDetailScreen = HouseDetailsView()
    
    var post: House?
    
    override func loadView() {
        view = houseDetailScreen
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        
        if let post = post {
            updateView(with: post)
        }

    }
    
    func updateView(with post: House) {
        houseDetailScreen.labelOwner.text = "\(post.ownerName)'s Place"

        if let imageUrl = URL(string: post.housePhoto), let imageData = try? Data(contentsOf: imageUrl) {
            houseDetailScreen.imageHouse.image = UIImage(data: imageData)
        } else {
            // Handle error or set a default image
            houseDetailScreen.imageHouse.image = UIImage(systemName: "house")
        }

        houseDetailScreen.labelPost.text = post.description
    }
    
    


}
