//
//  HouseListTableViewManager.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/7/23.
//

import Foundation
import UIKit

extension HouseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewHouseID, for: indexPath) as! HouseListTableViewCell
        let post = houseList[indexPath.row]

        cell.labelLocation.text = "\(post.address), \(post.city), \(post.state)"
        cell.labelDateRange.text = "Date: \(post.startDate) - \(post.endDate)"

        // Fetch and set the image asynchronously
        if let imageUrl = URL(string: post.housePhoto) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        cell.imageHouse.image = UIImage(data: data)
                    }
                } else {
                    DispatchQueue.main.async {
                        // Handle error or set a default image
                        cell.imageHouse.image = UIImage(systemName: "house")
                    }
                }
            }.resume()
        } else {
            cell.imageHouse.image = UIImage(systemName: "house") // default image if URL is invalid
        }

        return cell
    }

    // Handling row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let houseDetailsVC = HouseDetailsViewController()
        
        // Get the selected cell
        if let cell = tableView.cellForRow(at: indexPath) as? HouseListTableViewCell {
            // Get the image at the row
            if let selectedImage = cell.imageHouse.image{
                // Update the image instead re-download it
                houseDetailsVC.houseDetailScreen.imageHouse.image = selectedImage
            }else{
                houseDetailsVC.houseDetailScreen.imageHouse.image = UIImage(systemName: "house")
            }
        }
        
        let selectedPost = houseList[indexPath.row]
        
        print("Row \(indexPath.row) tapped")
        // Passing the selected post to the details view controller
        houseDetailsVC.post = selectedPost
        // Update post information before we push the controller
        houseDetailsVC.updatePostInfo(post: selectedPost)
        houseDetailsVC.configureButton(post: selectedPost)
        navigationController?.pushViewController(houseDetailsVC, animated: true)
    }
}


//if let houseURL = URL(string: selectedPost.housePhoto) {
//    // Use a completion handler to wait for the image download to be finished
//    FirestoreUtility.loadImageToImage(from: houseURL, into: houseDetailsVC.houseDetailScreen.imageHouse) { success in
//        if success {
//            // Image download completed
//            houseDetailsVC.updatePostInfo(post: selectedPost)
//            self.navigationController?.pushViewController(houseDetailsVC, animated: true)
//        } else {
//            // Image download failed
//            print("Error downloading image.")
//        }
//    }
//} else {
//    houseDetailsVC.houseDetailScreen.imageHouse.image = UIImage(systemName: "house")
//    houseDetailsVC.updatePostInfo(post: selectedPost)
//    navigationController?.pushViewController(houseDetailsVC, animated: true)
//}
