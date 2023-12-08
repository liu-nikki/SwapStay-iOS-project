//
//  ChatsTableViewManager.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/8/23.
//

import Foundation
import UIKit

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatsTableViewCell
        cell.labelName.text    = chats[indexPath.row].name
        cell.labelAddress.text = chats[indexPath.row].address
        cell.labelDate.text    = chats[indexPath.row].date
        return cell
    }
    
    // when the user click the row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select is working!!!")
       
    }
}
