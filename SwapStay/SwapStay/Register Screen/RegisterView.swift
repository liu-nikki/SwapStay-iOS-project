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
    var textUserName: UITextField!
    var textPhoneNumber: UITextField!
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
        setupTextUserName()
        setupTextPhoneNumber()
        
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
        //set a background to it, which shows a camera icon instead of text. So, we set an empty title
        buttonAddProfilePhoto.setTitle("", for: .normal)
        //set an image of the system name, "camera.fill".
        // buttonAddProfilePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
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
               
            buttonRegister.topAnchor.constraint(equalTo: textPhoneNumber.bottomAnchor, constant: 64),
            buttonRegister.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonRegister.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
