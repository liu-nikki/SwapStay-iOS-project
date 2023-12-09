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
        let selectedPost = houseList[indexPath.row]
        print("Row \(indexPath.row) tapped")
        
        let houseDetailsVC = HouseDetailsViewController()
        houseDetailsVC.post = selectedPost // Passing the selected post to the details view controller
        navigationController?.pushViewController(houseDetailsVC, animated: true)
    }
}

