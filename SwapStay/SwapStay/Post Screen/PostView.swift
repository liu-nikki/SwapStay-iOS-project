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
        setupArrowLabel()
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
    
    func setupbuttonTakePhoto(){
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }

    func setupUploadLabel() {
        uploadLabel.text = "Upload Photo of Your Home!"
        uploadLabel.textAlignment = .center
        uploadLabel.font = UIFont(name: "GillSans-SemiBold", size: 20)
        uploadLabel.textColor = .systemTeal
        uploadLabel.layer.shadowColor = UIColor.gray.cgColor
        uploadLabel.layer.shadowRadius = 1.0
        uploadLabel.layer.shadowOpacity = 1.0
        uploadLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        uploadLabel.layer.masksToBounds = false
        uploadLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(uploadLabel)
    }

    func setupAddressTextField() {
        addressTextField.borderStyle = .roundedRect
        addressTextField.layer.borderWidth = 1
        addressTextField.layer.cornerRadius = 5
        addressTextField.layer.borderColor = UIColor.gray.cgColor
        addressTextField.attributedPlaceholder = NSAttributedString(string: "Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressTextField)
    }

    func setupCityTextField() {
        cityTextField.borderStyle = .roundedRect
        cityTextField.layer.borderWidth = 1
        cityTextField.layer.cornerRadius = 5
        cityTextField.layer.borderColor = UIColor.gray.cgColor
        cityTextField.attributedPlaceholder = NSAttributedString(string: "City", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cityTextField)
    }

    func setupStateTextField() {
        stateTextField.borderStyle = .roundedRect
        stateTextField.layer.borderWidth = 1
        stateTextField.layer.cornerRadius = 5
        stateTextField.layer.borderColor = UIColor.gray.cgColor
        stateTextField.attributedPlaceholder = NSAttributedString(string: "State", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        stateTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stateTextField)
    }

    func setupZipTextField() {
        zipTextField.placeholder = "Zip"
        zipTextField.borderStyle = .roundedRect
        zipTextField.layer.borderWidth = 1
        zipTextField.layer.cornerRadius = 5
        zipTextField.layer.borderColor = UIColor.gray.cgColor
        zipTextField.attributedPlaceholder = NSAttributedString(string: "Zip", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(zipTextField)
    }

    func setupDateFromButton() {
        configureDatePicker(datePicker: datePickerFrom)
        dateFromButton.inputView = datePickerFrom
        dateFromButton.attributedPlaceholder = NSAttributedString(string: "Date From", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        dateFromButton.layer.borderWidth = 1
        dateFromButton.layer.cornerRadius = 5
        dateFromButton.layer.borderColor = UIColor.gray.cgColor
        dateFromButton.borderStyle = .roundedRect
        dateFromButton.backgroundColor = .systemGray3
        dateFromButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateFromButton)
    }

    func setupDateToButton() {
        configureDatePicker(datePicker: datePickerTo)
        dateToButton.inputView = datePickerTo
        dateToButton.attributedPlaceholder = NSAttributedString(string: "Date To", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        dateToButton.layer.borderWidth = 1
        dateToButton.layer.cornerRadius = 5
        dateToButton.borderStyle = .roundedRect
        dateToButton.layer.borderColor = UIColor.gray.cgColor
        dateToButton.backgroundColor = .systemGray3
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
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionTextView)
    }

    func setupPostButton() {
        postButton.setTitle("Post", for: .normal)
        postButton.setTitleColor(.white, for: .normal)
        postButton.backgroundColor = .black
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
            uploadLabel.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor),

            // Address TextField Constraints
            addressTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            addressTextField.topAnchor.constraint(equalTo: uploadLabel.bottomAnchor, constant: 20),
            addressTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            addressTextField.heightAnchor.constraint(equalToConstant: 40),

            // City TextField Constraints
            cityTextField.leadingAnchor.constraint(equalTo: addressTextField.leadingAnchor),
            cityTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10),
            cityTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
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
            dateFromButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            dateFromButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 10),
            dateFromButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            dateFromButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Arrow Label Constraints
            arrowLabel.centerYAnchor.constraint(equalTo: dateFromButton.centerYAnchor),
            arrowLabel.leadingAnchor.constraint(equalTo: dateFromButton.trailingAnchor, constant: 8),
            arrowLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 10),
            arrowLabel.trailingAnchor.constraint(equalTo: dateToButton.leadingAnchor, constant: -8),

            // Date To Button Constraints
            dateToButton.leadingAnchor.constraint(equalTo: arrowLabel.trailingAnchor, constant: 8),
            dateToButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 10),
            dateToButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            dateToButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Description TextView Constraints
            descriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: dateFromButton.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: dateFromButton.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: dateToButton.trailingAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150), // Adjust as needed

            // Post Button Constraints
            postButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            postButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            postButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            postButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
