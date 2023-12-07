//
//  UserManager.swift
//  SwapStay
//
//  Created by Kaylin Lau on 12/6/23.
//

import Foundation
import UIKit

class UserManager {
    static let shared = UserManager()
    var currentUser: User?

    private let imageCache = NSCache<NSString, UIImage>()

    private init() {}

    // Image caching functions
    func cacheImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }

    func getCachedImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}

// Extension for Notification.Name
extension Notification.Name {
    static let userProfileUpdated = Notification.Name("userProfileUpdated")
}
