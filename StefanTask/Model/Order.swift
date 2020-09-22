//
//  Order.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 06/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import Foundation


class Order {
    
    private var _pickupDetails: [PickupDetails] = []
    private var _deliveryDetails: [DeliveryDetails] = []
    private var _note: String?

    var pickupDetails: [PickupDetails] {
        get {
            return _pickupDetails
        }
        set{
            _pickupDetails = newValue
        }
    }
    
    var deliveryDetails: [DeliveryDetails] {
        get {
            return _deliveryDetails
        }
        set {
            _deliveryDetails = newValue
        }
    }
    
    var note: String {
        get {
            return _note ?? ""
        }
        set{
            _note = newValue
        }
    }
    
    
    
}
