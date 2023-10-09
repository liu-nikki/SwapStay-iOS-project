//
//  DetailScreenViewController.swift
//  WA4_Liu_8556
//
//  Created by Nikki Liu on 10/3/23.
//

import UIKit

class DetailScreenViewController: UIViewController {
    
    
    let showProfile = DetailScreenView()
    
    override func loadView() {
        view = showProfile
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setProfileData(name: String, email: String, phone: Int, type: String, address: String, city: String, zip: String) {
        showProfile.labelName.text = name
        showProfile.labelEmail.text = "Email: \(email)"
        showProfile.labelPhone.text = "Phone: \(phone) (\(type))"
        showProfile.labelAddress.text = "Address: "
        showProfile.labelAddressDetail.text = address
        showProfile.labelCity.text = city
        showProfile.labelZip.text = zip
        
    }
}
