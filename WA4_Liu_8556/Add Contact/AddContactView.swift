//
//  AddContactView.swift
//  WA4_Liu_8556
//
//  Created by Nikki Liu on 10/2/23.
//

import UIKit

class AddContactView: UIView {
    
    var labelAppName: UILabel!
    var textName: UITextField!
    var textEmail: UITextField!
    var labelAddPhone: UILabel!
    var pickerType: UIPickerView!
    var textPhoneNumber: UITextField!
    var textAddress: UITextField!
    var textCityState: UITextField!
    var textZipcode: UITextField!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //MARK: set the background color...
        self.backgroundColor = .white
        
        //MARK: initializing the UI elements and constraints...
        setupLabelAppName()
        setupTextName()
        setupTextEmail()
        setupLabelAddPhone()
        setupPickerType()
        setupTextPhoneNumber()
        setupTextAddress()
        setupTextCityState()
        setupTextZipcode()
        
        initConstraints()
    }
    //MARK: initializing the UI elements...
    func setupLabelAppName(){
        labelAppName = UILabel()
        labelAppName.text = "Add a New Contact"
        labelAppName.font = labelAppName.font.withSize(30)
        labelAppName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAppName)
    }
    func setupTextName(){
        textName = UITextField()
        textName.placeholder = "Name"
        textName.borderStyle = .roundedRect
        textName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textName)
    }
    func setupTextEmail(){
        textEmail = UITextField()
        textEmail.placeholder = "Email"
        textEmail.borderStyle = .roundedRect
        textEmail.keyboardType = .emailAddress
        textEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textEmail)
    }
    func setupLabelAddPhone(){
        labelAddPhone = UILabel()
        labelAddPhone.text = "Add Phone"
        labelAddPhone.font = labelAddPhone.font.withSize(25)
        labelAddPhone.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddPhone)
    }
    func setupPickerType(){
        pickerType = UIPickerView()
        pickerType.isUserInteractionEnabled = true
        pickerType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pickerType)
    }
    func setupTextPhoneNumber(){
        textPhoneNumber = UITextField()
        textPhoneNumber.placeholder = "Phone Number"
        textPhoneNumber.borderStyle = .roundedRect
        textPhoneNumber.keyboardType = .phonePad
        textPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textPhoneNumber)
    }
    func setupTextAddress(){
        textAddress = UITextField()
        textAddress.placeholder = "Address"
        textAddress.borderStyle = .roundedRect
        textAddress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textAddress)
    }
    func setupTextCityState(){
        textCityState = UITextField()
        textCityState.placeholder = "City, State"
        textCityState.borderStyle = .roundedRect
        textCityState.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textCityState)
    }
    func setupTextZipcode(){
        textZipcode = UITextField()
        textZipcode.placeholder = "ZIP"
        textZipcode.borderStyle = .roundedRect
        textZipcode.keyboardType = .numberPad
        textZipcode.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textZipcode)
    }

    
    //MARK: initializing constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelAppName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25),
            labelAppName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textName.topAnchor.constraint(equalTo: labelAppName.bottomAnchor, constant: 16),
            textName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textEmail.topAnchor.constraint(equalTo: textName.bottomAnchor, constant: 16),
            textEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            labelAddPhone.topAnchor.constraint(equalTo: textEmail.bottomAnchor, constant: 16),
            labelAddPhone.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            pickerType.topAnchor.constraint(equalTo: labelAddPhone.bottomAnchor, constant: 0),
            pickerType.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textPhoneNumber.topAnchor.constraint(equalTo: pickerType.bottomAnchor, constant: 16),
            textPhoneNumber.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textPhoneNumber.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textPhoneNumber.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textAddress.topAnchor.constraint(equalTo: textPhoneNumber.bottomAnchor, constant: 16),
            textAddress.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textAddress.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textAddress.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textCityState.topAnchor.constraint(equalTo: textAddress.bottomAnchor, constant: 16),
            textCityState.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textCityState.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textCityState.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textZipcode.topAnchor.constraint(equalTo: textCityState.bottomAnchor, constant: 16),
            textZipcode.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textZipcode.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textZipcode.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
