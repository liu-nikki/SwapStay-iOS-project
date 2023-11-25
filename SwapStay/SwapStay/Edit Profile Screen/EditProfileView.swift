//
//  EditProfileView.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit

class EditProfileView: UIView {
    
    //var contentWrapper:UIScrollView!
    //var contentView: UIView!
    var buttonEditProfilePhoto: UIButton!
    var labelEditProfilePhoto: UILabel!
    var textFieldName: UITextField!
    var textPhoneNumber: UITextField!
    var textFieldLine1: UITextField!
    var textFieldLine2: UITextField!
    var textFieldCity: UITextField!
    var textFieldState: UITextField!
    var textFieldZip: UITextField!
    var buttonSave: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupButtonEditProfilePhoto()
        setupLabelEditProfilePhoto()
        setupTextFieldName()
        setupTextFieldPhoneNumber()
        setupTextFieldLine1()
        setupTextFieldLine2()
        setupTextFieldCity()
        setupTextFieldState()
        setupTextFieldZip()
        
        
        setupButtonSave()
        
        
        initConstraints()
    }
 
    func setupButtonEditProfilePhoto()
    {
        buttonEditProfilePhoto = UIButton()
        //et a background to it, which shows a camera icon instead of text. So, we set an empty title
        buttonEditProfilePhoto.setTitle("", for: .normal)
        //set an image of the system name, "camera.fill".
        //buttonAddProfilePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        // Set a custom image from the asset catalog
        buttonEditProfilePhoto.setImage(UIImage(named: "AppDefaultProfiePic"), for: .normal)
        //contents of this button can fill the whole width of the button
        buttonEditProfilePhoto.contentHorizontalAlignment = .fill
        //image of the button fill the height of the button
        buttonEditProfilePhoto.contentVerticalAlignment = .fill
        //set the frame of the image so that the image can be loaded with the content mode
        buttonEditProfilePhoto.imageView?.contentMode = .scaleAspectFit
        buttonEditProfilePhoto.showsMenuAsPrimaryAction = true
        buttonEditProfilePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonEditProfilePhoto)
    }
    
    func setupLabelEditProfilePhoto()
    {
        labelEditProfilePhoto = UILabel()
        labelEditProfilePhoto.translatesAutoresizingMaskIntoConstraints = false
        labelEditProfilePhoto.text = "Edit Profile Photo"
        labelEditProfilePhoto.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(labelEditProfilePhoto)
    }
    
    func setupTextFieldName()
    {
        textFieldName = UITextField()
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        textFieldName.placeholder = "Name"
        textFieldName.borderStyle = .roundedRect
        self.addSubview(textFieldName)
    }
    
    // generate corresponding functions
    
    
    
    
//    func setupTextFieldUserName()
//    {
//        textUserName = UITextField()
//        textUserName.translatesAutoresizingMaskIntoConstraints = false
//        textUserName.placeholder = "Username"
//        textUserName.borderStyle = .roundedRect
//        self.addSubview(textUserName)
//    }
    
//    func setupTextFieldPassword()
//    {
//        textFieldPassword = UITextField()
//        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
//        textFieldPassword.placeholder = "Password"
//        textFieldPassword.borderStyle = .roundedRect
//        self.addSubview(textFieldPassword)
//    }
//    
//    func setupTextFieldPasswordConfirm()
//    {
//        textFieldPasswordConfirm = UITextField()
//        textFieldPasswordConfirm.translatesAutoresizingMaskIntoConstraints = false
//        textFieldPasswordConfirm.placeholder = "Confirm Password"
//        textFieldPasswordConfirm.borderStyle = .roundedRect
//        self.addSubview(textFieldPasswordConfirm)
//    }
    
    func setupTextFieldLine1() {
        textFieldLine1 = UITextField()
        textFieldLine1.translatesAutoresizingMaskIntoConstraints = false
        textFieldLine1.placeholder = "Address Line 1"
        textFieldLine1.borderStyle = .roundedRect
        self.addSubview(textFieldLine1)
    }

    func setupTextFieldLine2() {
        textFieldLine2 = UITextField()
        textFieldLine2.translatesAutoresizingMaskIntoConstraints = false
        textFieldLine2.placeholder = "Address Line 2"
        textFieldLine2.borderStyle = .roundedRect
        self.addSubview(textFieldLine2)
    }

    func setupTextFieldCity() {
        textFieldCity = UITextField()
        textFieldCity.translatesAutoresizingMaskIntoConstraints = false
        textFieldCity.placeholder = "City"
        textFieldCity.borderStyle = .roundedRect
        self.addSubview(textFieldCity)
    }

    func setupTextFieldState() {
        textFieldState = UITextField()
        textFieldState.translatesAutoresizingMaskIntoConstraints = false
        textFieldState.placeholder = "State"
        textFieldState.borderStyle = .roundedRect
        self.addSubview(textFieldState)
    }

    func setupTextFieldZip() {
        textFieldZip = UITextField()
        textFieldZip.translatesAutoresizingMaskIntoConstraints = false
        textFieldZip.placeholder = "Zip"
        textFieldZip.borderStyle = .roundedRect
        self.addSubview(textFieldZip)
    }
    
    func setupTextFieldPhoneNumber()
    {
        textPhoneNumber = UITextField()
        textPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        textPhoneNumber.placeholder = "Phone Number"
        textPhoneNumber.borderStyle = .roundedRect
        self.addSubview(textPhoneNumber)
    }
    
    func setupButtonSave()
    {
        buttonSave = UIButton()
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonSave.setTitleColor(.white, for: .normal)
        buttonSave.backgroundColor = .black
        buttonSave.layer.cornerRadius = 3
        buttonSave.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSave)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            buttonEditProfilePhoto.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            buttonEditProfilePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonEditProfilePhoto.widthAnchor.constraint(equalToConstant: 150),
            buttonEditProfilePhoto.heightAnchor.constraint(equalToConstant: 150),
            
            labelEditProfilePhoto.topAnchor.constraint(equalTo: self.buttonEditProfilePhoto.bottomAnchor, constant: 16),
            labelEditProfilePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
//            textUserName.topAnchor.constraint(equalTo: labelEditProfilePhoto.bottomAnchor, constant: 64),
//            textUserName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            textUserName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldName.topAnchor.constraint(equalTo: labelEditProfilePhoto.bottomAnchor, constant: 16),
            textFieldName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
        
//            textFieldPassword.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
//            textFieldPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            textFieldPassword.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
//            
//            textFieldPasswordConfirm.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
//            textFieldPasswordConfirm.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            textFieldPasswordConfirm.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textPhoneNumber.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            textPhoneNumber.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textPhoneNumber.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldLine1.topAnchor.constraint(equalTo: textPhoneNumber.bottomAnchor, constant: 16),
            textFieldLine1.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldLine1.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),

            textFieldLine2.topAnchor.constraint(equalTo: textFieldLine1.bottomAnchor, constant: 16),
            textFieldLine2.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldLine2.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),

            // City TextField Constraints
            textFieldCity.topAnchor.constraint(equalTo: textFieldLine2.bottomAnchor, constant: 16),
            textFieldCity.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldCity.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: -16),

            // State TextField Constraints
            textFieldState.topAnchor.constraint(equalTo: textFieldLine2.bottomAnchor, constant: 16),
            textFieldState.leadingAnchor.constraint(equalTo: textFieldCity.trailingAnchor, constant: 8),
            textFieldState.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25, constant: -12),

            // Zip TextField Constraints
            textFieldZip.topAnchor.constraint(equalTo: textFieldLine2.bottomAnchor, constant: 16),
            textFieldZip.leadingAnchor.constraint(equalTo: textFieldState.trailingAnchor, constant: 8),
            textFieldZip.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            // Zip field's width is automatically determined by its leading and trailing constraints

            buttonSave.topAnchor.constraint(equalTo: textFieldZip.bottomAnchor, constant: 64),
            buttonSave.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonSave.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
        
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
