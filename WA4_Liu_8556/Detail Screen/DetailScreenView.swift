//
//  DetailScreenView.swift
//  WA4_Liu_8556
//
//  Created by Nikki Liu on 10/3/23.
//

import UIKit

class DetailScreenView: UIView {

    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPhone: UILabel!
    var labelAddress: UILabel!
    var labelAddressDetail: UILabel!
    var labelCity: UILabel!
    var labelZip: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white

        // Initialize the UI elements and constraints
        setupLabelName()
        setupLabelEmail()
        setupLabelPhone()
        setupLabelAddress()
        setupLabelAddressDetail()
        setupLabelCity()
        setupLabelZip()

        initConstraints()
    }

    // Initialize the UI elements for displaying profile information
    func setupLabelName() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 30)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }

    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.font = labelEmail.font.withSize(20)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }

    func setupLabelPhone() {
        labelPhone = UILabel()
        labelPhone.font = labelPhone.font.withSize(20)
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPhone)
    }

    func setupLabelAddress() {
        labelAddress = UILabel()
        labelAddress.font = UIFont.boldSystemFont(ofSize: 25)
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddress)
    }
    
    func setupLabelAddressDetail() {
        labelAddressDetail = UILabel()
        labelAddressDetail.font = labelAddressDetail.font.withSize(20)
        labelAddressDetail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddressDetail)
    }
    
    func setupLabelCity() {
        labelCity = UILabel()
        labelCity.font = labelCity.font.withSize(20)
        labelCity.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCity)
    }

    func setupLabelZip() {
        labelZip = UILabel()
        labelZip.font = labelZip.font.withSize(20)
        labelZip.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelZip)
    }
   
    // Initialize constraints for displaying profile information labels
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
    
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20),
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            labelPhone.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
            labelPhone.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            labelAddress.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 16),
            labelAddress.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
       
            labelAddressDetail.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 5),
            labelAddressDetail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelCity.topAnchor.constraint(equalTo: labelAddressDetail.bottomAnchor, constant: 1),
            labelCity.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            labelZip.topAnchor.constraint(equalTo: labelCity.bottomAnchor, constant: 1),
            labelZip.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),


        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
