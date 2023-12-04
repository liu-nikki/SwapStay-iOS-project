//
//  ChatViewController.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/3/23.
//

// MARK: Temp view controller for chats
import UIKit

class ChatsViewController: UIViewController {
    let cahtsView          = ChatsView()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = cahtsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}
