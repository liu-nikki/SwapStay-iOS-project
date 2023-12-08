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

        cell.labelLocation.text = "\(post.city), \(post.state)"
        cell.labelDateRange.text = "Date: \(post.startDate) - \(post.endDate)"
      
        
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
