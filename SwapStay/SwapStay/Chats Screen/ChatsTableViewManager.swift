//
//  ChatsTableViewManager.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/8/23.
//

import Foundation
import UIKit

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatsTableViewCell
        let chat = chats[indexPath.row]

        // Configure cell with chat details
        cell.labelName.text = chat.name
        cell.labelAddress.text = chat.address
        cell.labelDate.text = formatDate(chat.date)
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = chats[indexPath.row]
        let messagesVC = MessagesViewController()
        
        let conversation = Chat(ChatId: chat.ChatId, name: chat.name, email: "participants", address: chat.address, date: chat.date)
        messagesVC.receiver = conversation
        
        self.navigationController?.pushViewController(messagesVC, animated: true)
    }
    

    // Helper method to format the date
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
