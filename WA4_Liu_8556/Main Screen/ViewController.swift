//
//  ViewController.swift
//  WA4_Liu_8556
//
//  Created by Nikki Liu on 10/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    
    override func loadView() {
        view = mainScreen
    }
    
    var contacts = [Contact]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Contacts"
        
        //MARK: patching the table view delegate and datasource to controller...
        mainScreen.tableViewContact.delegate = self
        mainScreen.tableViewContact.dataSource = self
        
        //MARK: setting the add button to the navigation controller...
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(onAddBarButtonTapped)
        )
    }
    
    @objc func onAddBarButtonTapped(){
        let addContactController = AddContactViewController()
        addContactController.delegate = self
        navigationController?.pushViewController(addContactController, animated: true)
    }
    
    //MARK: got the new expense back and delegated to ViewController...
    func delegateOnAddContact(contact: Contact){
        contacts.append(contact)
        mainScreen.tableViewContact.reloadData()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath) as! TableViewContactCell
        cell.labelName.text = contacts[indexPath.row].name
        if let email = contacts[indexPath.row].email{
            cell.labelEmail.text = email
        }
        if let phone = contacts[indexPath.row].phone,
           let type = contacts[indexPath.row].type {
            cell.labelPhone.text = "\(phone)(\(type))"
        }
        return cell
    }
    
    //MARK: deal with user interaction with a cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showDetailController = DetailScreenViewController()
        if let name = contacts[indexPath.row].name,
           let email = contacts[indexPath.row].email,
           let phone = contacts[indexPath.row].phone,
           let type = contacts[indexPath.row].type,
           let address = contacts[indexPath.row].address,
           let city = contacts[indexPath.row].city,
           let zip = contacts[indexPath.row].zip {
            showDetailController.setProfileData(name: name, email: email, phone: phone, type: type, address: address, city: city, zip: zip)
            navigationController?.pushViewController(showDetailController, animated: true)
        } else {
            return
        }
    }
    
    
}

