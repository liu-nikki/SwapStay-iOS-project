//
//  HouseListView.swift
//  SwapStay
//
//  Created by Yu Zou on 11/22/23.
//

import UIKit

class HouseListView: UIView {
    
    
    var appTitle: UILabel!
    var profilePic: UIButton!
    var labelWelcome: UILabel!
    var buttonPost: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupAppTitle()
        setupProfilePic()
        setupLabelWelcome()
        setupButtonTmpPost()
        
        initConstraints()
        
    }
    
    //MARK: initializing the UI element
    
    func setupAppTitle(){
        appTitle = UILabel()
        appTitle.text = "Swap Stay"
        appTitle.font = UIFont(name: "Arial-BoldMT", size: 30)
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(appTitle)
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
    
    func setupLabelWelcome(){
        labelWelcome = UILabel()
        labelWelcome.text = "Welcome User!"
        labelWelcome.font = UIFont(name: "Arial-BoldMT", size: 15)
        labelWelcome.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelWelcome)
    }
    
    func setupButtonTmpPost(){
        buttonPost = UIButton(type: .system)
        buttonPost.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonPost.setTitle("Post", for: .normal)
        buttonPost.translatesAutoresizingMaskIntoConstraints = false
    
        buttonPost.setTitleColor(.white, for: .normal)
        buttonPost.backgroundColor = .systemTeal
        buttonPost.layer.cornerRadius = 5
        buttonPost.layer.masksToBounds = true
        self.addSubview(buttonPost)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            appTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -64),
            appTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            profilePic.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 16),
            profilePic.widthAnchor.constraint(equalToConstant: 56),
            profilePic.heightAnchor.constraint(equalToConstant: 56),
            profilePic.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            labelWelcome.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 32),
            labelWelcome.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 16),
            
            buttonPost.topAnchor.constraint(equalTo: labelWelcome.bottomAnchor, constant: 16),
            buttonPost.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
