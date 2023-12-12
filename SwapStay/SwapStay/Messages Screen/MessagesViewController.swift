//
//  MessagesViewController.swift
//  WA8_11
//
//  Created by 李凱鈞 on 11/16/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MessagesViewController: UIViewController {

    let messagesScreen = MessagesView()
    var handleAuth: AuthStateDidChangeListenerHandle?   // use this listener to track whether any user is signed in.
    let database = Firestore.firestore()    // a variable to keep an instance of the current signed-in Firebase user.
    
    var currentUser:       User?
    var receiver: Chat!                                 //has info about the post, such as post ownername, email, address and date
    var currentChatID: String?

    var messagesList = [Message]()
    
    override func loadView() {
        view = messagesScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        // Print user and receiver data
        printCurrentUserData()
        printReceiverData()
        

    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = receiver.name
        
        // Set up button action
        messagesScreen.buttonPost.addTarget(self, action: #selector(postMessage), for: .touchUpInside)
        //MARK: patching table view delegate and date source.
        messagesScreen.tableViewMessages.delegate = self
        messagesScreen.tableViewMessages.dataSource = self
        //MARK: removing the separator line.
        messagesScreen.tableViewMessages.separatorStyle = .none
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        let currentUserEmail = UserManager.shared.currentUser?.email
        
        // Check for an existing chat with the receiver
            checkForExistingChat(with: receiver) { [weak self] chatID in
                guard let self = self else { return }

                if let chatID = chatID {
                    // An existing chat was found
                    self.currentChatID = chatID
                    self.fetchAllMessages(chatID: chatID)
                    print("Existing chat found with ID: \(chatID)")
                } else {
                    // No existing chat found
                    // Here, you can choose to do nothing and wait until the user sends a message
                    // to create a new chat. Alternatively, you can initialize some UI elements or
                    // display a message indicating that this is a new chat.
                    print("No existing chat found with the receiver. A new chat will be created upon sending a message.")
                }
            }
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }


    private func checkForExistingChat(with receiver: Chat, completion: @escaping (String?) -> Void) {
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            print("Current user email is not available")
            completion(nil)
            return
        }

        // Querying the user's 'chats' subcollection
        database.collection("users").document(currentUserEmail).collection("chats")
            .whereField("receiverEmail", isEqualTo: receiver.email)
            .getDocuments { (snapshot, error) in
             
                if let error = error {
                    print("Error checking for existing chat: \(error)")
                    completion(nil)
                    return
                }

                if let documents = snapshot?.documents,
                   let chatDocument = documents.first(where: { $0.documentID != "placeholder id" }) {
                    // Existing chat found and it's not the placeholder, return the chat ID
                    completion(chatDocument.documentID)
                } else {
                    // No existing chat found or only placeholder is present, create a new one
                    self.createChat(with: receiver, currentUserEmail: currentUserEmail)
                }
            }
    }


    private func createChat(with receiver: Chat, currentUserEmail: String) {
        let newChatID = database.collection("users").document(currentUserEmail).collection("chats").document().documentID

        // set the receiver to the post owner email
        let currentUserChatData: [String: Any] = ["receiverEmail": receiver.email]
        // set the poster's chat receiver to the current user email
        let receiverChatData: [String: Any] = ["receiverEmail": currentUserEmail]

        // Data for the actual chat document in the 'chats' root collection
        let chatData: [String: Any] = [
            "participants": [currentUserEmail, receiver.email],
            "namePoster": receiver.name,
            "address": receiver.address,
            "date": receiver.date
        ]
        
        // Create chat document for the current user
        database.collection("users").document(currentUserEmail).collection("chats").document(newChatID).setData(currentUserChatData) { error in
            if let error = error {
                print("Error writing chat document for current user: \(error)")
            } else {
                print("Chat document for current user successfully written with ID: \(newChatID)")
            }
        }

        // Create corresponding chat document for the receiver
        database.collection("users").document(receiver.email).collection("chats").document(newChatID).setData(receiverChatData) { error in
            if let error = error {
                print("Error writing chat document for receiver: \(error)")
            } else {
                print("Chat document for receiver successfully written with ID: \(newChatID)")
            }
        }
        
        // Create the actual chat document in the 'chats' root collection
        database.collection("chats").document(newChatID).setData(chatData) { error in
            if let error = error {
                print("Error creating chat in root collection: \(error)")
            } else {
                print("Chat created in root collection successfully with ID: \(newChatID)")
            }
        }
    
        self.currentChatID = newChatID
    }
    
    //MARK: post message function
    @objc private func postMessage() {
        
        print("Post Message function")

        // Print the text from the textView
        print("Text from textView: \(String(describing: messagesScreen.textViewNote.text))")

        // Check if the message text is empty
        guard let messageText = messagesScreen.textViewNote.text, !messageText.isEmpty else {
            print("Message text is empty")
            return
        }

        // Check if the currentChatID is set
        guard let chatID = self.currentChatID else {
                print("Current chat ID is nil")
                return
            }
            print("Current Chat ID: \(chatID)")

        // Check if the currentUser's email is available
        guard let currentUserEmail = Auth.auth().currentUser?.email else {
            print("Current user's email is nil")
            return
        }
        print("Sender Email: \(currentUserEmail)")
        
        // Check if the currentUser's name is available
        guard let currentUserName = Auth.auth().currentUser?.displayName else {
            print("Current user's name is nil")
            return
        }
        print("Sender Name: \(currentUserName)")
        
        // get messages collection
        let messageCollection = database.collection("chats").document(chatID).collection("messages")
        // create a message object
        let newMessage = Message(senderEmail: currentUserEmail, senderName: currentUserName, text: messageText, timestamp: Date())
        do{
            // add message
            try messageCollection.addDocument(from: newMessage, completion: {(error) in
                if error == nil{
                    print("Message saved successfully")
                    // Clear text field after sending
                    self.messagesScreen.textViewNote.text = ""
                }
            })
        }catch{
            print("Error saving message: \(error)")
        }
        // add to messagesList
        self.messagesList.append(newMessage)
    }
    
    private func fetchAllMessages(chatID: String){
        self.database.collection("chats").document(chatID).collection("messages")
            .order(by: "timestamp", descending: false)  // Assuming you want to order by timestamp
            .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                if let error = error {
                    print("Error fetching messages: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No messages found for chat ID: \(chatID)")
                    return
                }
                self.messagesList.removeAll()
                
                for document in documents {
                    do {
                        let message = try document.data(as: Message.self)
                        self.messagesList.append(message)
//                                print("Message retrieved: \(message)")
                    } catch {
                        print("Error decoding message: \(error)")
                    }
                }
                
                self.messagesScreen.tableViewMessages.reloadData()
                self.scrollToBottom()
        })
    }

    func scrollToBottom() {
        let numberOfSections = messagesScreen.tableViewMessages.numberOfSections
        let numberOfRows = messagesScreen.tableViewMessages.numberOfRows(inSection: numberOfSections - 1)
        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
            messagesScreen.tableViewMessages.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    private func printCurrentUserData() {
        if let user = UserManager.shared.currentUser {
            print("Current User Data:")
            print("ID: \(user.id ?? "nil")")
            print("Name: \(user.name)")
            print("Email: \(user.email)")
            print("Profile Image URL: \(user.profileImageURL ?? "nil")")
            print("Phone: \(user.phone)")
            print("Address: \(user.address?.formattedAddress() ?? "nil")")
        } else {
            print("Current user is nil")
        }
    }
    
    private func printReceiverData() {
        if let chat = receiver {
            print("Receiver Data:")
            print("Chat ID: \(chat.ChatId)")
            print("Name: \(chat.name)")
            print("Email: \(chat.email)")
            print("Address: \(chat.address)")
            print("Date: \(chat.date)")
        } else {
            print("Receiver is nil")
        }
    }
    
    

    
    

}


