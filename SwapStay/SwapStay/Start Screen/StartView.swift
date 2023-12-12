//
//  LoadingView.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/3/23.
//  It's a just a start view. The user will see this screen once opens the app

import UIKit

class StartView: UIView {
    var boxView: UIView!
    var appImageView: UIImageView!
    var buttonSend: UIButton!
    var labelReceived: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupAppImageView()
    }
        func setupAppImageView(){
            appImageView = UIImageView()
            appImageView.image = UIImage(named: "AppStartingPage")
            appImageView.contentMode = .scaleAspectFit
            appImageView.clipsToBounds = true
            appImageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(appImageView)
        }
    
        func initConstraints(){
            NSLayoutConstraint.activate([
                appImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                appImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
                appImageView.widthAnchor.constraint(equalToConstant: 150),
                appImageView.heightAnchor.constraint(equalToConstant: 150)
            ])
            
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
