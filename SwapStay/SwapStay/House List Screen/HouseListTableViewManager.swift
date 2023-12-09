//
//  HouseListTableViewManager.swift
//  SwapStay
//
//  Created by 李凱鈞 on 12/7/23.
//

import Foundation
import UIKit

extension HouseListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewHouseID, for: indexPath) as! HouseListTableViewCell
        let post = houseList[indexPath.row]

        cell.labelLocation.text = "\(post.address), \(post.city), \(post.state)"
        cell.labelDateRange.text = "Date: \(post.startDate) - \(post.endDate)"
        
        // Fetch and set the image
        if let imageUrl = URL(string: post.housePhoto) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageHouse.image = UIImage(data: data)
                    }
                } else {
                    // Handle error or set a default image
                    DispatchQueue.main.async {
                        cell.imageHouse.image = UIImage(systemName: "house")
                    }
                }
            }.resume()
        } else {
            cell.imageHouse.image = UIImage(systemName: "house") // default image if URL is invalid
        }
            
        
        return cell
    }
    
    // when the user click the row
    // not working right now
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = houseList[indexPath.row]
        print("Select is working!!!")

        let houseDetailsVC = HouseDetailsViewController()
        navigationController?.pushViewController(houseDetailsVC, animated: true)
    }
}
