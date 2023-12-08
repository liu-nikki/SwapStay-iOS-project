//
//  HouseListTableViewCell.swift
//  WA5
//
//  Created by 李凱鈞 on 12/6/23.
//

import UIKit

class HouseListTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var imageHouse:      UIImageView!
    var labelLocation:   UILabel!
    var labelDateRange:  UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setupWrapperCellView()
        setupImageHouse()
        setupLabelLocation()
        setupLabelDateRange()
            
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor     = .white
        wrapperCellView.layer.cornerRadius  = 15.0
        wrapperCellView.layer.shadowColor   = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset  = .zero
        wrapperCellView.layer.shadowRadius  = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupImageHouse(){
        imageHouse               = UIImageView()
        imageHouse.image         = UIImage(systemName: "house")
        imageHouse.contentMode   = .scaleToFill
        imageHouse.clipsToBounds = true
        // Make the corners of the ImageView rounded with a radius of 10.
        // imagePerson.layer.cornerRadius = 10
        imageHouse.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imageHouse)
    }
    
    func setupLabelLocation(){
        labelLocation      = UILabel()
        labelLocation.text = "USA, Los Angeles"
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLocation)
    }
    
    func setupLabelDateRange(){
        labelDateRange      = UILabel()
        labelDateRange.text = "Date: 12/12/2023 - 12/31/2023"
        labelDateRange.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDateRange)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
          
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            // width
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            // height
            wrapperCellView.heightAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
            
            imageHouse.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 0),
            imageHouse.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 0),
            imageHouse.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: 0),
            imageHouse.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -80),
            
            labelLocation.topAnchor.constraint(equalTo: imageHouse.bottomAnchor, constant: 20),
            labelLocation.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            
            labelDateRange.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 0),
            labelDateRange.leadingAnchor.constraint(equalTo: labelLocation.leadingAnchor, constant: 0),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
