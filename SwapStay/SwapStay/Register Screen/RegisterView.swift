//
//  RegisterView.swift
//  SwapStay
//
//  Created by Nikki Liu on 11/18/23.
//

import UIKit

class RegisterView: UIView {
    
    var labelAppTitle: UILabel!
    var buttonAddProfilePhoto: UIButton!
//    var labelAddProfilePhoto: UILabel!
    var textUserName: UITextField!
    var textPhoneNumber: UITextField!
//    var textAddress: UITextField!
//    var textCity: UITextField!
//    var textState: UITextField!
//    var textZipCode: UITextField!    
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var textFieldPasswordConfirm: UITextField!
    var buttonRegister: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setuplabelAppTitle()
        setupbuttonAddProfilePhoto()
//        setuplabelAddProfilePhoto()
        setupTextUserName()
        setupTextPhoneNumber()
//        setupTextAddress()
//        setupTextCity()
//        setupTextState()
//        setupTextZipCode()
       
        setuptextFieldName()
        setuptextFieldEmail()
        setuptextFieldPassword()
        setuptextFieldPasswordConfirm()
        setupbuttonRegister()
        
        initConstraints()
    }
    
    func setuplabelAppTitle(){
        labelAppTitle = UILabel()
        labelAppTitle.numberOfLines = 2
        labelAppTitle.text = "Swap Stay"
        labelAppTitle.font = UIFont(name: "Arial-BoldMT", size: 30)
        labelAppTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAppTitle)
    }
    
    func setupbuttonAddProfilePhoto() {
        buttonAddProfilePhoto = UIButton()
        //et a background to it, which shows a camera icon instead of text. So, we set an empty title
        buttonAddProfilePhoto.setTitle("", for: .normal)
        //set an image of the system name, "camera.fill".
        //buttonAddProfilePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        // Set a custom image from the asset catalog
        buttonAddProfilePhoto.setImage(UIImage(named: "AppDefaultProfiePic"), for: .normal)
        //contents of this button can fill the whole width of the button
        buttonAddProfilePhoto.contentHorizontalAlignment = .fill
        //image of the button fill the height of the button
        buttonAddProfilePhoto.contentVerticalAlignment = .fill
        //set the frame of the image so that the image can be loaded with the content mode
        buttonAddProfilePhoto.imageView?.contentMode = .scaleAspectFit
        buttonAddProfilePhoto.showsMenuAsPrimaryAction = true
        buttonAddProfilePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonAddProfilePhoto)
    }
    
//    func setuplabelAddProfilePhoto() {
//        labelAddProfilePhoto = UILabel()
//        labelAddProfilePhoto.text = "Add Profile Photo"
//        //set text color to black
//        labelAddProfilePhoto.textColor = .black
//        labelAddProfilePhoto.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(labelAddProfilePhoto)
//    }
//    
    func setupTextUserName(){
        textUserName = UITextField()
        textUserName.placeholder = "Username"
        //set placeholder text color to black
        textUserName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textUserName.keyboardType = .default
        textUserName.borderStyle = .roundedRect
        textUserName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textUserName)
    }
    
    func setupTextPhoneNumber() {
        textPhoneNumber = UITextField()
        textPhoneNumber.placeholder = "Phone"
        //set placeholder text color to black
        textPhoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textPhoneNumber.borderStyle = .roundedRect
        // set keypad type is phonePad
        textPhoneNumber.keyboardType = .phonePad
        textPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textPhoneNumber)
        
    }
    
//    func setupTextAddress() {
//        textAddress = UITextField()
//        textAddress.placeholder = "Address"
//        textAddress.borderStyle = .roundedRect
//        textAddress.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(textAddress)
//        
//    }
//    
//    func setupTextCity() {
//        textCity = UITextField()
//        textCity.placeholder = "City"
//        textCity.borderStyle = .roundedRect
//        textCity.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(textCity)
//        
//    }
//    
//    func setupTextState() {
//        textState = UITextField()
//        textState.placeholder = "State"
//        textState.borderStyle = .roundedRect
//        textState.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(textState)
//        
//    }
//    
//    func setupTextZipCode() {
//        textZipCode = UITextField()
//        textZipCode.placeholder = "ZIP"
//        textZipCode.borderStyle = .roundedRect
//        // set keypad type is phonePad
//        textZipCode.keyboardType = .numberPad
//        // limit digit to 5
//        textZipCode.textContentType = .postalCode
//        textZipCode.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(textZipCode)
//        
//    }
    
    func setuptextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        //set placeholder text color to black
        textFieldName.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textFieldName.keyboardType = .default
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setuptextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        //set placeholder text color to black
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        //set placeholder text color to black
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textFieldPassword.textContentType = .password
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setuptextFieldPasswordConfirm(){
        textFieldPasswordConfirm = UITextField()
        textFieldPasswordConfirm.placeholder = "Confirm Password"
        //set placeholder text color to black
        textFieldPasswordConfirm.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textFieldPasswordConfirm.textContentType = .password
        textFieldPasswordConfirm.isSecureTextEntry = true
        textFieldPasswordConfirm.borderStyle = .roundedRect
        textFieldPasswordConfirm.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPasswordConfirm)
    }
    
    func setupbuttonRegister(){
        buttonRegister = UIButton()
        buttonRegister.setTitle("Sign Up", for: .normal)
        buttonRegister.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonRegister.setTitleColor(.white, for: .normal)
        buttonRegister.backgroundColor = .black
        buttonRegister.layer.cornerRadius = 3
        buttonRegister.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonRegister)

    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelAppTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 2),
            labelAppTitle.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonAddProfilePhoto.topAnchor.constraint(equalTo: labelAppTitle.bottomAnchor, constant: 16),
            buttonAddProfilePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonAddProfilePhoto.widthAnchor.constraint(equalToConstant: 150),
            buttonAddProfilePhoto.heightAnchor.constraint(equalToConstant: 150),
            
//            labelAddProfilePhoto.topAnchor.constraint(equalTo: buttonAddProfilePhoto.bottomAnchor, constant: 8),
//            labelAddProfilePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            
            
            textUserName.topAnchor.constraint(equalTo: buttonAddProfilePhoto.bottomAnchor, constant: 64),
            textUserName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textUserName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldName.topAnchor.constraint(equalTo: textUserName.bottomAnchor, constant: 16),
            textFieldName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            textFieldEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldEmail.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldPassword.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textFieldPasswordConfirm.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            textFieldPasswordConfirm.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldPasswordConfirm.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            textPhoneNumber.topAnchor.constraint(equalTo: textFieldPasswordConfirm.bottomAnchor, constant: 16),
            textPhoneNumber.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textPhoneNumber.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
//            textAddress.topAnchor.constraint(equalTo: textPhoneNumber.bottomAnchor, constant: 16),
//            textAddress.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            textAddress.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
//            
//            textCity.topAnchor.constraint(equalTo: textAddress.bottomAnchor, constant: 16),
//            textCity.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            
//            textState.topAnchor.constraint(equalTo: textAddress.bottomAnchor, constant: 16),
//            textState.leadingAnchor.constraint(equalTo: textCity.trailingAnchor, constant: 16),
//            
//            textZipCode.topAnchor.constraint(equalTo: textAddress.bottomAnchor, constant: 16),
//            textZipCode.leadingAnchor.constraint(equalTo: textState.trailingAnchor, constant: 16),
//
//            textZipCode.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            
//            // Equal Widths for City, State, and Zip Code TextFields
//            textCity.widthAnchor.constraint(equalTo: textState.widthAnchor),
//            textState.widthAnchor.constraint(equalTo: textZipCode.widthAnchor),
            
            buttonRegister.topAnchor.constraint(equalTo: textPhoneNumber.bottomAnchor, constant: 64),
            buttonRegister.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonRegister.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
