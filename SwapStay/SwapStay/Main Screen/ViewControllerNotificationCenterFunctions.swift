//
//  ViewControllerNotificationCenterFunctions.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/11/23.
//

import Foundation
import UIKit

extension ViewController{
    // Add a observer to observer login screen
    func addDissMissLoginScreenObserver(){
        notificationCenter.addObserver(
            self,
            selector: #selector(dismissLogin(notification:)),
            name: .loginSuccessfully,
            object: nil)
    }
    
    // When user login successfully, get rid of login screen
    @objc func dismissLogin(notification: Notification) {
        // dismiss the presented login screen
        self.dismiss(animated: true, completion: nil)
    }
    
    // Add observer to observe profile pic
    func addProfilePicTappedObserver(){
        notificationCenter.addObserver(
            self,
            selector: #selector(testSelectIndex(notification:)),
            name: .userProfilePicTapped,
            object: nil)
    }
    
    // Redirect to profile screen
    @objc func testSelectIndex(notification: Notification){
        self.selectedIndex = 2
    }
    
    // Add a observer to observer house details screen book chat buttton
    func addSwitchToChatObserver(){
        notificationCenter.addObserver(
            self,
            selector: #selector(switchToChatsTab(notification:)),
            name: .switchToChatsTab,
            object: nil)
    }
    
    
    @objc func switchToChatsTab(notification: Notification) {
        self.selectedIndex = 1
    }


}




//   navController.pushViewController(messagesVC, animated: true)
//        // Retrieve the MessagesViewController from the notification
//        if let messagesVC = notification.object as? MessagesViewController {
//            if let navController = self.viewControllers?[1] as? UINavigationController {
//                // Set the back button title for the top view controller on the stack
//                let backItem   = UIBarButtonItem()
//                backItem.title = "Chats"
//                navController.topViewController?.navigationItem.backBarButtonItem = backItem
//                // Push MessagesViewController onto the navigation stack
//                navController.pushViewController(messagesVC, animated: true)
//            }
//        }
