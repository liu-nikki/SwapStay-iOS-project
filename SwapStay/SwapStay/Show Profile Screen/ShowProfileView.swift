//
//  ShowProfileView.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit

class ShowProfileView: UIView {
    
    var imageProfile: UIImageView!
    var labelProfile: UILabel!
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPhone: UILabel!
    var labelAddress: UILabel!
    var buttonEdit: UIButton!
    var buttonEditPassword: UIButton!
    var buttonLogOut: UIButton!
    
    //MARK: view initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setting background color
        self.backgroundColor = .white
        
        setupImageProfile()
        setupLabelProfile()
        setupLabelEmail()
        setupLabelName()
        setupLabelPhone()
        setupLabelAddress()
        setupButtonEdit()
        setupButtonEditPassword()
        setupButtonLogOut()
        
        initConstraints()
        
    }
    
    func setupImageProfile(){
        imageProfile = UIImageView()
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        imageProfile.image = UIImage(named: "AppDefaultProfiePic")
        self.addSubview(imageProfile)
    }
    
    func setupLabelProfile()
    {
        labelProfile = UILabel()
        labelProfile.translatesAutoresizingMaskIntoConstraints = false
        labelProfile.text = "Profile"
        labelProfile.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(labelProfile)
        
    }
    
    func setupLabelName()
    {
        labelName = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.text = "Name: "
        labelName.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(labelName)
        
    }
    
    func setupLabelEmail()
    {
        labelEmail = UILabel()
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.text = "Email: "
        labelEmail.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(labelEmail)

    }
    
    func setupLabelPhone()
    {
        labelPhone = UILabel()
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        labelPhone.text = "Phone: "
        labelPhone.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(labelPhone)
    }
    
    func setupLabelAddress(){
        labelAddress = UILabel()
        labelAddress.text = "Address"
        labelAddress.font = UIFont.systemFont(ofSize: 20)
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        labelAddress.numberOfLines = 0
        labelAddress.lineBreakMode = .byWordWrapping
        self.addSubview(labelAddress)
    }
    
    func setupButtonEdit(){
        buttonEdit = UIButton()
        buttonEdit.setTitle("Edit", for: .normal)
        buttonEdit.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonEdit.setTitleColor(.white, for: .normal)
        buttonEdit.backgroundColor = .black
        buttonEdit.layer.cornerRadius = 3
        buttonEdit.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonEdit.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonEdit)
    }
    
    func setupButtonEditPassword(){
        buttonEditPassword = UIButton()
        buttonEditPassword.setTitle("Edit Password", for: .normal)
        buttonEditPassword.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonEditPassword.setTitleColor(.white, for: .normal)
        buttonEditPassword.backgroundColor = .black
        buttonEditPassword.layer.cornerRadius = 3
        buttonEditPassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonEditPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonEditPassword)
    }
    
    func setupButtonLogOut() {
        buttonLogOut = UIButton()
        buttonLogOut.setTitle("Log Out", for: .normal)
        buttonLogOut.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonLogOut.setTitleColor(.white, for: .normal)
        buttonLogOut.backgroundColor = .black
        buttonLogOut.layer.cornerRadius = 3
        buttonLogOut.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonLogOut.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogOut)
    }
    
    
    //MARK: initializing the constraints.
    func initConstraints() {
        NSLayoutConstraint.activate([
            imageProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageProfile.widthAnchor.constraint(equalToConstant: 100),
            imageProfile.heightAnchor.constraint(equalToConstant: 100),
            
            labelProfile.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 20),
            labelProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelName.topAnchor.constraint(equalTo: labelProfile.bottomAnchor, constant: 20),
            labelName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20),
            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                   
            labelPhone.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 20),
            labelPhone.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            labelAddress.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 20),
            labelAddress.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            buttonEdit.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 32),
            buttonEdit.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonEdit.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120),
            buttonEdit.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -120),
            
            buttonEditPassword.topAnchor.constraint(equalTo: buttonEdit.bottomAnchor, constant: 16),
            buttonEditPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonEditPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120),
            buttonEditPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -120),
            
            buttonLogOut.topAnchor.constraint(equalTo: buttonEditPassword.bottomAnchor, constant: 16),
            buttonLogOut.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonLogOut.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120),
            buttonLogOut.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -120),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
