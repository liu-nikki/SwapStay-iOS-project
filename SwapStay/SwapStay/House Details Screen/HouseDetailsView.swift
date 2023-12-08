//
//  HouseDetailView.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/4/23.
//

import UIKit

class HouseDetailsView: UIView {

    var imageHouse: UIImageView!
    var labelOwner: UILabel!
    var labelPost:  UILabel!
    var buttonBook: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupImageHouse()
        setupLabelOwner()
        setupLabelPost()
        setupButtonBook()
        
        initConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageHouse(){
        imageHouse = UIImageView()
        // default
        imageHouse.image = UIImage(systemName: "photo")
        
        // fill the ImageView with the image by resizing it
        imageHouse.contentMode = .scaleToFill
        // clip the image if it overflows the ImageView frame.
        imageHouse.clipsToBounds = true
        // make the corners of the ImageView rounded with a radius of 10.
        // imagePerson.layer.cornerRadius = 10
        
        imageHouse.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageHouse)
    }
    
    func setupLabelOwner(){
        labelOwner = UILabel()
        labelOwner.text = "Who's Place"
        labelOwner.font = UIFont.boldSystemFont(ofSize: 32)
        labelOwner.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelOwner)
    }
    
    func setupLabelPost(){
        labelPost = UILabel()
        labelPost.text = "San Jose, California, is the third-largest city and a tech hub, known as the Capital of Silicon Valley. It boasts a diverse population, a strong economy fueled by technology companies, and a Mediterranean climate. Home to San Jose State University, the city offers cultural attractions and recreational opportunities in a thriving urban environment."
        labelPost.font = UIFont.boldSystemFont(ofSize: 16)
        // Allow multiple lines
        labelPost.numberOfLines = 0
        // Handle word wrapping
        labelPost.lineBreakMode = .byWordWrapping
        labelPost.sizeToFit()
        labelPost.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPost)
    }
    
    func setupButtonBook(){
        buttonBook = UIButton()
        buttonBook.setTitle("Book Room", for: .normal)
        //set the button font to 20
        buttonBook.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonBook.setTitleColor(.white, for: .normal)
        buttonBook.backgroundColor = .black
        buttonBook.layer.cornerRadius = 3
        // set the button height to 20
        buttonBook.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonBook.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonBook)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            
            imageHouse.heightAnchor.constraint(equalToConstant: 100),
            imageHouse.widthAnchor.constraint(equalToConstant:  100),
            
            imageHouse.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 48),
            imageHouse.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelOwner.topAnchor.constraint(equalTo: imageHouse.bottomAnchor, constant: 16),
            labelOwner.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelPost.topAnchor.constraint(equalTo: labelOwner.bottomAnchor, constant: 8),
            labelPost.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            labelPost.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
          //  labelPost.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8),
            
            buttonBook.topAnchor.constraint(equalTo: labelPost.bottomAnchor, constant: 32),
            buttonBook.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonBook.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120),
            buttonBook.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -120),

        ])
    }
}
