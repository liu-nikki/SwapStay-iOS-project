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

//        let house = houseList[indexPath.row]
//        cell.imageHouse.image    = UIImage(data: house.houseImg)
//        cell.labelLocation.text  = house.address
//
//        if let dateFrom = house.dateFrom, let dateTo = house.dateTo{
//
//            cell.labelDateRange.text = "\(dateFrom) - \(dateTo)"
//        }else{
//            cell.labelDateRange.text = "Date range is not avaliable!"
//        }
        
        
        // Test part
        cell.imageHouse.image    = UIImage(systemName: "house")
        cell.labelLocation.text  = "USA, Los Angeles"
        cell.labelDateRange.text = "Date: 12/12/2023 - 12/31/2023"
        
        return cell
    }
    
    // when the user click the row
    // not working right now
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("Select is working!!!")

//        let houseDetailsVC = HouseDetailsViewController()
//        navigationController?.pushViewController(houseDetailsVC, animated: true)
    }
}
