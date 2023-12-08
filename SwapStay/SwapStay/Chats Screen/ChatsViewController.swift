//
//  ChatViewController.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/3/23.
//

// MARK: Temp view controller for chats
import UIKit

class ChatsViewController: UIViewController {
    let cahtsScreen          = ChatsView()
    let notificationCenter   = NotificationCenter.default
    var chats                = [Chat]()
    
    override func loadView() {
        view = cahtsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //MARK: patching table view delegate and date source.
        cahtsScreen.tableViewChats.delegate   = self
        cahtsScreen.tableViewChats.dataSource = self
        
        //MARK: removing the separator line.
        cahtsScreen.tableViewChats.separatorStyle = .none
        
        
        let chat  = Chat(name: "Kenny", address: "San Jose, CA", date: "12/11/2023 - 12/30/2023")
        let chat1 = Chat(name: "Patrick", address: "Tucson, AZ", date: "12/11/2023 - 12/30/2023")
        chats.append(chat)
        chats.append(chat1)
    }
}
