//
//  ChatViewController.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/3/23.
//

import UIKit

class ChatViewController: UIViewController {
    let redView = ChatView()
    
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = redView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
