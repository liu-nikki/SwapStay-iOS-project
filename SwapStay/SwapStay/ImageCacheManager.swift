//
//  File.swift
//  SwapStay
//
//  Created by Kaylin Lau on 12/5/23.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}

    private var imageCache = NSCache<NSString, UIImage>()

    func getImage(forUrl url: String, completion: @escaping (UIImage?) -> Void) {
        // Check if image exists in cache
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
            return
        }

        // If not in cache, download it
        if let imageUrl = URL(string: url) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self.imageCache.setObject(image, forKey: url as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
    }
}
