//
//  MainScreenView.swift
//  SwapStay
//
//  Created by Nikki Liu on 11/18/23.
//

import UIKit

class MainScreenView: UIView {
    
    var contentWrapper:UIScrollView!
    var contentView: UIView!
    var profilePic: UIButton!
    var labelText: UILabel!
    var tableViewHouseInfo: UITableView!
    
    var appTitle: UILabel!
    var appImageView: UIImageView!
    var loginLabel: UILabel!
    var loginEmailTextField: UITextField!
    var loginPasswordTextField: UITextField!
    var loginButton: UIButton!
    var registerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
//        setupProfilePic()
//        setupLabelText()
//        setupTableViewHouseInfo()
        
        setupAppTitle()
        setupAppImageView()
        setupLoginLabel()
        setupLoginEmailTextField()
        setupLoginPasswordTextField()
        setupLoginButton()
        setupRegisterButton()
        initConstraints()
    }
    
    //MARK: initializing the UI elements...

    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(contentView)
    }
    
    func setupAppTitle(){
        appTitle = UILabel()
        appTitle.numberOfLines = 2
        appTitle.text = "Swap\n Stay"
        appTitle.font = UIFont(name: "Arial-BoldMT", size: 40)
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(appTitle)
    }
    
    func setupAppImageView(){
        appImageView = UIImageView()
        appImageView.image = UIImage(named: "AppMS")
        appImageView.contentMode = .scaleAspectFit
        appImageView.clipsToBounds = true
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(appImageView)
    }
    
    func setupLoginLabel(){
        loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.font = .boldSystemFont(ofSize: 35)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(loginLabel)
    }
    
    func setupLoginEmailTextField(){
        loginEmailTextField = UITextField()
        loginEmailTextField.placeholder = "Email"
        //set placeholder color to black
        loginEmailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        //no auto capitalization
        loginEmailTextField.autocapitalizationType = .none
        loginEmailTextField.borderStyle = .roundedRect
        loginEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(loginEmailTextField)
    }
    
    func setupLoginPasswordTextField(){
        loginPasswordTextField = UITextField()
        loginPasswordTextField.placeholder = "Password"
        //set placeholder color to black
        loginPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        loginPasswordTextField.autocapitalizationType = .none
        loginPasswordTextField.isSecureTextEntry = true
        loginPasswordTextField.borderStyle = .roundedRect
        
        // Create a UIImageView with a lock symbol
        let lockImageView = UIImageView()
        lockImageView.image = UIImage(systemName: "lock.fill") // Using a system icon for lock
        lockImageView.tintColor = .black
        lockImageView.contentMode = .scaleAspectFit
        lockImageView.frame = CGRect(x: 0, y: 0, width: lockImageView.intrinsicContentSize.width + 10, height: lockImageView.intrinsicContentSize.height)
        
        // Add padding to the left of the image view
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: lockImageView.frame.width + 10, height: lockImageView.frame.height))
        paddingView.addSubview(lockImageView)

        // Set the lock image view as the left view of the text field
        loginPasswordTextField.rightView = paddingView
        loginPasswordTextField.rightViewMode = .always
        
        loginPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(loginPasswordTextField)
    }
    
    func setupLoginButton(){
        loginButton = UIButton()
        loginButton.setTitle("Login  ➔", for: .normal)
        //set the button font to 20
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 3
        // set the button height to 20
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(loginButton)
    }
    
    func setupRegisterButton(){
        registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        //set the button color to black
        registerButton.backgroundColor = .black
        registerButton.layer.cornerRadius = 5
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(registerButton)
    }
    
    func setupProfilePic(){
        profilePic = UIButton()
        profilePic.setTitle("", for: .normal)
        profilePic.setImage(UIImage(named: "AppDefaultProfiePic"), for: .normal)
        profilePic.contentHorizontalAlignment = .fill
        //image of the button fill the height of the button
        profilePic.contentVerticalAlignment = .fill
        //set the frame of the image so that the image can be loaded with the content mode
        profilePic.imageView?.contentMode = .scaleAspectFit
        profilePic.showsMenuAsPrimaryAction = true
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profilePic)
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelText)
    }
    
    func setupTableViewHouseInfo(){
        tableViewHouseInfo = UITableView()
        tableViewHouseInfo.register(HouseTableViewCell.self, forCellReuseIdentifier: Configs.tableViewHouseID)
        tableViewHouseInfo.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(tableViewHouseInfo)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            //MARK: contentWrapper constraints
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            contentView.topAnchor.constraint(equalTo: contentWrapper.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: contentWrapper.widthAnchor),
            
//            profilePic.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 8),
//            profilePic.widthAnchor.constraint(equalToConstant: 32),
//            profilePic.heightAnchor.constraint(equalToConstant: 32),
//            profilePic.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            
//            labelText.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 8),
//            labelText.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor),
//            labelText.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 8),
            
//            tableViewHouseInfo.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 8),
//            tableViewHouseInfo.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -8),
//            tableViewHouseInfo.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
//            tableViewHouseInfo.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            appTitle.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 2),
            appTitle.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            appImageView.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 8),
            appImageView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            appImageView.heightAnchor.constraint(equalToConstant: 350),
            appImageView.widthAnchor.constraint(equalToConstant: 700),
            
            loginLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 400),
            loginLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            
            loginEmailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 24),
            loginEmailTextField.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            loginEmailTextField.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            loginPasswordTextField.topAnchor.constraint(equalTo: loginEmailTextField.bottomAnchor, constant: 16),
            loginPasswordTextField.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            loginPasswordTextField.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            loginButton.topAnchor.constraint(equalTo: loginPasswordTextField.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -16),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 56),
            registerButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            registerButton.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 120),
            registerButton.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -120),
            registerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
