//
//  DeliveryDetailsCell.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 08/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import UIKit

protocol DeliveryCellDelegate {
    func addDeliveryDetailsButtonTapped(cell: DeliveryDetailsCell)
    func calendButtonTapped(cell: DeliveryDetailsCell)
    func templateButtonTapped(cell: DeliveryDetailsCell)
    func radioButtonTapped(cell: DeliveryDetailsCell)
    func deliveryFormFilled(address: String, name: String, phoneNumber: String, email: String,template: String,cell: DeliveryDetailsCell)
}

class DeliveryDetailsCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var deliveryDetailsAddButton: UIButton!
    @IBOutlet weak var deliveryDetailsAddress: UITextField!
    @IBOutlet weak var deliveryDetailsName: UITextField!
    @IBOutlet weak var deliveryDetailsPhone: UITextField!
    @IBOutlet weak var deliveryDetailsEmail: UITextField!
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var templateNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var templateButton: UIButton!
    
    
    var delegate: DeliveryCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
        setupRadioButtonLook(button: radioButton)
        deliveryDetailsEmail.delegate = self
        deliveryDetailsPhone.delegate = self
        deliveryDetailsName.delegate = self
        deliveryDetailsAddress.delegate = self
        setupRadioButtonLook(button: radioButton)
        templateButton.isEnabled = false
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()

         contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
     }

    //MARK: - My Functions
    
    func configureDeliveryDetailsCell(deliveryDetails: DeliveryDetails) {
        deliveryDetailsAddress.text = deliveryDetails.pickupAddress
        deliveryDetailsName.text = deliveryDetails.name
        deliveryDetailsPhone.text = deliveryDetails.phoneNumber
        deliveryDetailsEmail.text = deliveryDetails.email
        templateNameLabel.text = deliveryDetails.template
        dateTimeLabel.text = deliveryDetails.pickupDate
    }
    
 
    
    func setupRadioButtonLook(button: UIButton) {
        button.layer.cornerRadius = radioButton.frame.size.width / 2.0
          button.clipsToBounds = true
          button.setBackgroundImage(UIImage(named: "Background"), for: .normal)
          button.setImage(nil, for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        deliveryDetailsAddButton.isEnabled = false
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        deliveryDetailsAddButton.isEnabled = true
        delegate?.deliveryFormFilled(address: deliveryDetailsAddress.text!, name: deliveryDetailsName.text!, phoneNumber: deliveryDetailsPhone.text!, email: deliveryDetailsEmail.text!, template: templateNameLabel.text!, cell: self)
     }
    
    // MARK: - Actions
    @IBAction func deliveryAddButtonTapped(_ sender: UIButton) {
        delegate?.addDeliveryDetailsButtonTapped(cell: self)
        
    }
    @IBAction func templateButtonTapped(_ sender: UIButton) {
        delegate?.templateButtonTapped(cell: self)
        
        
    }
    @IBAction func deliveryCalendarButtonTapped(_ sender: UIButton) {
        delegate?.calendButtonTapped(cell: self)
    }
    @IBAction func radioButtonTapped(_ sender: UIButton) {
        
        delegate?.radioButtonTapped(cell: self)
    }
    
}
