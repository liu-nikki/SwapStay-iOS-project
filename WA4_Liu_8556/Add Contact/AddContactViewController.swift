//
//  AddContactViewController.swift
//  WA4_Liu_8556
//
//  Created by Nikki Liu on 10/2/23.
//

import UIKit

class AddContactViewController: UIViewController {
    
    let createProfile = AddContactView()
    
    override func loadView() {
        view = createProfile
    }
    
    let types: [String] = ["Cell", "Work", "Home"]
    
    var selectedType = "Cell"
    
    var delegate:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createProfile.pickerType.delegate = self
        createProfile.pickerType.dataSource = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        view.addGestureRecognizer(tapRecognizer)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(onSaveBarButtonTapped)
        )
    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    @objc func onSaveBarButtonTapped(){
        var name: String?
        if let nameText = createProfile.textName.text{
            if !nameText.isEmpty {
                name = nameText
            } else {
                return
            }
        }
        
        var email: String?
        if let emailText = createProfile.textEmail.text{
            if isValidEmail(emailText) {
                email = emailText
            } else {
                showAlert(message: "Please provide a valid email address!")
                return
            }
        }
        
        var phone: Int?
        if let phoneText = createProfile.textPhoneNumber.text{
            if phoneText.count == 10 {
                phone = Int(phoneText)
            } else {
                showAlert(message: "Please provide a valid phone number!")
                return
            }
        }
        
        var address: String?
        var cityAndstate: String?
        if let addressText = createProfile.textAddress.text,
           let cityAndstateText = createProfile.textCityState.text{
            if !addressText.isEmpty && !cityAndstateText.isEmpty {
                address = addressText
                cityAndstate = cityAndstateText
            } else {
                showAlert(message: "The field cannot be empty!")
                return
            }
        }
        
        var zip: String?
        if let zipText = createProfile.textZipcode.text {
            if zipText.count == 5 {
                zip = zipText
            } else {
                showAlert(message: "Please provide a valid zipcode!")
                return
            }
        }
            
        let newContact = Contact(name: name, email: email, phone: phone, type: selectedType, address: address, city: cityAndstate, zip: zip)
        delegate.delegateOnAddContact(contact: newContact)
        navigationController?.popViewController(animated: true)
            
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }


}


extension AddContactViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    //returns the number of columns/components in the Picker View...
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //returns the number of rows in the current component...
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Utilities.types.count
    }
    
    //set the title of currently picked row...
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // on change selection, update selectedMood...
        selectedType = Utilities.types[row]
        return Utilities.types[row]
    }
}
