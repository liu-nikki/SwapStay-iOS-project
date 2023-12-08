//
//  PostView.swift
//  SwapStay
//
//  Created by Kaylin Lau on 12/5/23.
//

import UIKit

class PostView: UIView {

    // UI Components
    let titleLabel = UILabel()
    var buttonTakePhoto = UIButton()
    let uploadLabel = UILabel()
    let addressTextField = UITextField()
    let cityTextField = UITextField()
    let stateTextField = UITextField()
    let zipTextField = UITextField()
    let dateFromButton = UITextField()
    let dateToButton = UITextField()
    let arrowLabel = UILabel()
    let descriptionTextView = UITextView()
    let postButton = UIButton()
    let datePickerFrom = UIDatePicker()
    let datePickerTo = UIDatePicker()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupTitleLabel()
        setupbuttonTakePhoto()
        setupUploadLabel()
        setupAddressTextField()
        setupCityTextField()
        setupStateTextField()
        setupZipTextField()
        setupDateFromButton()
        setupDateToButton()
        setupDescriptionTextView()
        setupPostButton()

        setupConstraints()
    }



    // MARK: - UI Setup Functions
    func setupTitleLabel() {
        titleLabel.text = "Showcase Your Place"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }

//    func setupCameraButton() {
//        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 150, weight: .regular, scale: .large) // Adjust point size as needed
//        cameraButton.setImage(UIImage(systemName: "camera.fill", withConfiguration: symbolConfig), for: .normal)
//
//        cameraButton.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(cameraButton)
//    }
    
    func setupbuttonTakePhoto(){
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        //buttonTakePhoto.setImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }

    func setupUploadLabel() {
        uploadLabel.text = "Upload Your Home!"
        uploadLabel.textAlignment = .center
        uploadLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(uploadLabel)
    }

    func setupAddressTextField() {
        addressTextField.placeholder = "Address"
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressTextField)
    }

    func setupCityTextField() {
        cityTextField.placeholder = "City"
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cityTextField)
    }

    func setupStateTextField() {
        stateTextField.placeholder = "State"
        stateTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stateTextField)
    }

    func setupZipTextField() {
        zipTextField.placeholder = "Zip"
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(zipTextField)
    }

    func setupDateFromButton() {
        configureDatePicker(datePicker: datePickerFrom)
        dateFromButton.inputView = datePickerFrom
        dateFromButton.placeholder = "Date From"
        dateFromButton.backgroundColor = .lightGray
        dateFromButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateFromButton)
    }

    func setupDateToButton() {
        configureDatePicker(datePicker: datePickerTo)
        dateToButton.inputView = datePickerTo
        dateToButton.placeholder = "Date To"
        dateToButton.backgroundColor = .lightGray
        dateToButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateToButton)
    }
    
    private func configureDatePicker(datePicker: UIDatePicker) {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
    }
    
    @objc func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        if sender == datePickerFrom {
            dateFromButton.text = dateFormatter.string(from: sender.date)
        } else if sender == datePickerTo {
            dateToButton.text = dateFormatter.string(from: sender.date)
        }
    }


    func setupArrowLabel() {
        arrowLabel.text = "→" // Arrow symbol
        arrowLabel.textAlignment = .center
        arrowLabel.font = UIFont.systemFont(ofSize: 16) // Adjust font size as needed
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowLabel)
    }

    func setupDescriptionTextView() {
        descriptionTextView.layer.borderColor = UIColor.gray.cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.text = "Description"
        descriptionTextView.textColor = .lightGray
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionTextView)
    }

    func setupPostButton() {
        postButton.setTitle("Post", for: .normal)
        postButton.backgroundColor = .systemBlue
        postButton.layer.cornerRadius = 5
        postButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(postButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title Label Constraints
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),

            // Camera Button Constraints
            buttonTakePhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonTakePhoto.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100), // Adjust as needed
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100), // Adjust as needed

            // Upload Label Constraints
            uploadLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            uploadLabel.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 10),

            // Address TextField Constraints
            addressTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            addressTextField.topAnchor.constraint(equalTo: uploadLabel.bottomAnchor, constant: 10),
            addressTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            addressTextField.heightAnchor.constraint(equalToConstant: 40),

            // City TextField Constraints
            cityTextField.leadingAnchor.constraint(equalTo: addressTextField.leadingAnchor),
            cityTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10),
            cityTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            cityTextField.heightAnchor.constraint(equalToConstant: 40),

            // State TextField Constraints
            stateTextField.leadingAnchor.constraint(equalTo: cityTextField.trailingAnchor, constant: 10),
            stateTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10),
            stateTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            stateTextField.heightAnchor.constraint(equalToConstant: 40),

            // Zip TextField Constraints
            zipTextField.leadingAnchor.constraint(equalTo: stateTextField.trailingAnchor, constant: 10),
            zipTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10),
            zipTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            zipTextField.heightAnchor.constraint(equalToConstant: 40),

            // Date From Button Constraints
            dateFromButton.leadingAnchor.constraint(equalTo: addressTextField.leadingAnchor),
            dateFromButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 10),
            dateFromButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            dateFromButton.heightAnchor.constraint(equalToConstant: 40),

            // Date To Button Constraints
            dateToButton.trailingAnchor.constraint(equalTo: addressTextField.trailingAnchor),
            dateToButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 10),
            dateToButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            dateToButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Arrow Label Constraints
//            arrowLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            arrowLabel.topAnchor.constraint(equalTo: dateFromButton.bottomAnchor, constant: 10),
//            arrowLabel.widthAnchor.constraint(equalToConstant: 20), // Adjust width as needed
//            arrowLabel.heightAnchor.constraint(equalToConstant: 20), // Adjust height as needed
//
            // Description TextView Constraints
            descriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: dateFromButton.bottomAnchor, constant: 10),
            descriptionTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100), // Adjust as needed

            // Post Button Constraints
            postButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            postButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            postButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            postButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
