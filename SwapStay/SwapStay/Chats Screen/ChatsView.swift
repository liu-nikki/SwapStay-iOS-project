//
//  ChatView.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/3/23.
//

// MARK: Temp view for chats
import UIKit

class ChatsView: UIView {

    var tableViewChats: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupTableViewChats()
        initConstraints()
    }
    
    func setupTableViewChats(){
        tableViewChats = UITableView()
        tableViewChats.register(ChatsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewChatsID)
        tableViewChats.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewChats)
    }
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewChats.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor),
            tableViewChats.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewChats.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewChats.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
