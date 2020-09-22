//
//  PickupDetailsCellTableViewCell.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 03/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import UIKit

protocol PickupCellDelegate {
    func addButtonTapped(cell: PickupDetailsCellTableViewCell)
    func calendarButtonTapped(cell: PickupDetailsCellTableViewCell)
    func formFilled(address: String, name: String, phoneNumber: String,reNumber: String,cell: PickupDetailsCellTableViewCell)
}

class PickupDetailsCellTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rxNumberField: UITextField!
    

    var delegate: PickupCellDelegate?
    var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addressField.delegate = self
        nameField.delegate = self
        phoneNumberField.delegate = self
        rxNumberField.delegate = self
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        addButton.isEnabled = true
         delegate?.formFilled(address: addressField.text!, name: nameField.text!, phoneNumber: phoneNumberField.text!,reNumber: rxNumberField.text!,cell: self)
    }

    

    //MARK: - My Functions
    
    
    func configureCellWIthPickupDetails(pickupDetails: PickupDetails) {
        
        addressField.text = pickupDetails.pickupAddress
        nameField.text = pickupDetails.name
        phoneNumberField.text = pickupDetails.phoneNumber
        dateLabel.text = pickupDetails.pickupDate
        rxNumberField.text = pickupDetails.rxNumber
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        delegate?.addButtonTapped(cell: self)
      
        
    }
    
    @IBAction func calendarButtonTapped(_ sender: UIButton) {
        delegate?.calendarButtonTapped(cell:self)
    }
    
    
}
