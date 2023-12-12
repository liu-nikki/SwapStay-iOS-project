//
//  ChatViewController.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/3/23.
//

// MARK: Temp view controller for chats
import UIKit
import FirebaseFirestore
import FirebaseAuth

/// <#Description#>
class ChatsViewController: UIViewController {
    let chatsScreen          = ChatsView()
    let notificationCenter   = NotificationCenter.default
    let database             = Firestore.firestore()
    
    var chats                = [Chat]()
    var currentUser:       User?
    
    override func loadView() {
        view = chatsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.tintColor = .black
        
        //MARK: patching table view delegate and date source.
        chatsScreen.tableViewChats.delegate   = self
        chatsScreen.tableViewChats.dataSource = self
        
        //MARK: removing the separator line.
        chatsScreen.tableViewChats.separatorStyle = .none
        
        // Fetch chats for the current user
        fetchAllChatsForCurrentUser()
   
    }
    
    // MARK: fetch the all the conversations the current user has
    private func fetchAllChatsForCurrentUser() {
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            print("No logged-in user")
            return
        }

        // Query the 'chats' collection for chats where the current user is a participant
        database.collection("chats")
            .whereField("participants", arrayContains: currentUserEmail)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching chats: \(error)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No chats found")
                    return
                }

                for document in documents {
                    let chatData = document.data()
                    let namePoster = chatData["namePoster"] as? String ?? ""
                    let address = chatData["address"] as? String ?? ""
                    let date = (chatData["date"] as? Timestamp)?.dateValue() ?? Date()
                    let participants = chatData["participants"] as? [String] ?? []
                    
                    // Identify the other participant's email
                    let otherParticipantEmail = participants.first(where: { $0 != currentUserEmail }) ?? "Unknown"
                    
                    let chat = Chat(ChatId: document.documentID, name: namePoster, email: otherParticipantEmail, address: address, date: date)
                    self.chats.append(chat)
                    
                    //test delete later
                    print("Chat ID: \(document.documentID)")
                    print("Name Poster: \(namePoster)")
                    print("Address: \(address)")
                    print("Date: \(date)")
                    print("Participants: \(participants)")
                    
                }
                
                DispatchQueue.main.async {
                    self.chatsScreen.tableViewChats.reloadData()
                }

            }
    }


    
}
