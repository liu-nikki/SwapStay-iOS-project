//
//  ChatsTableViewCell.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/8/23.
//
import UIKit

class ChatsTableViewCell: UITableViewCell {
        
    var labelName:     UILabel!
    var labelAddress:  UILabel!
    var labelDate:     UILabel!
    
    var wrapperCellView: UIView!
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLabelAddress()
        setupLabelDate()
            
        initConstraints()
    }
        
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = .boldSystemFont(ofSize: 14)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    func setupLabelAddress(){
        labelAddress = UILabel()
        labelAddress.font = .boldSystemFont(ofSize: 14)
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddress)
    }
    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.font = .boldSystemFont(ofSize: 14)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDate)
    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            // width
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            // height
            wrapperCellView.heightAnchor.constraint(equalToConstant: 90),
           // wrapperCellView.heightAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            
            labelAddress.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelAddress.leadingAnchor.constraint(equalTo: labelName.leadingAnchor, constant: 0),
            
            labelDate.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 8),
            labelDate.leadingAnchor.constraint(equalTo: labelAddress.leadingAnchor, constant: 0),
            
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

        
        
        
        

        
