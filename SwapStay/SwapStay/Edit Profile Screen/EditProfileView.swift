//
//  EditProfileView.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit

class EditProfileView: UIView {
    
    var buttonEditProfilePhoto: UIButton!
    var labelEditProfilePhoto: UILabel!
    var textFieldName: UITextField!
    var textPhoneNumber: UITextField!

    var buttonSave: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupButtonEditProfilePhoto()
        setupLabelEditProfilePhoto()
        setupTextFieldName()
        setupTextFieldPhoneNumber()

        setupButtonSave()
        
        initConstraints()
    }
 
    func setupButtonEditProfilePhoto()
    {
        buttonEditProfilePhoto = UIButton()
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
            
            textFieldName.topAnchor.constraint(equalTo: labelEditProfilePhoto.bottomAnchor, constant: 16),
            textFieldName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldName.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
        
            textPhoneNumber.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            textPhoneNumber.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textPhoneNumber.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            
            buttonSave.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonSave.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonSave.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
