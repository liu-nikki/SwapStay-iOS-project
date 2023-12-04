//
//  LoadingView.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/3/23.
//  It's a just a start view. The user will see this screen once opens the app

import UIKit

class StartView: UIView {
    var boxView: UIView!
    var buttonSend: UIButton!
    var labelReceived: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        boxView = UIView()
        boxView.backgroundColor = .blue
        boxView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(boxView)
        
        buttonSend = UIButton(type: .system)
        buttonSend.setTitle("Send Hello", for: .normal)
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSend)
        
        labelReceived = UILabel()
        labelReceived.text = "Loading ..."
        labelReceived.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelReceived)
        
        
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            boxView.widthAnchor.constraint(equalToConstant: 200),
            boxView.heightAnchor.constraint(equalToConstant: 200),
            boxView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonSend.topAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: 8),
            buttonSend.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelReceived.topAnchor.constraint(equalTo: self.buttonSend.bottomAnchor, constant: 8),
            labelReceived.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
