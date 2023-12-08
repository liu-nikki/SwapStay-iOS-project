//
//  HouseDetailViewController.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/4/23.
//

import UIKit

class HouseDetailsViewController: UIViewController {
    
    let houseDetailScreen = HouseDetailsView()
    
    override func loadView() {
        view = houseDetailScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}
