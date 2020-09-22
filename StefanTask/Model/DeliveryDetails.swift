//
//  DeliveryDetails.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 08/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import Foundation


class DeliveryDetails {
    private var _pickupAddress: String?
       private var _name: String?
       private var _phoneNumber: String?
       private var _pickupDate: String?
       private var _email: String?
    private var _template: String?
       
       var pickupAddress: String {
           get {
               return _pickupAddress ?? ""
           }
           set{
               _pickupAddress = newValue
           }
       }
       
       
       var name: String {
           get {
               return _name ?? ""
           }
           set{
               _name = newValue
           }
       }
       
       var phoneNumber: String {
           get {
               return _phoneNumber ?? ""
           }
           set{
               _phoneNumber = newValue
           }
       }
       
       
       var pickupDate: String {
           get {
               return _pickupDate ?? "Select Date & Time"
           }
           set{
               _pickupDate = newValue
           }
       }
       
       
       var email: String {
           get {
               return _email ?? ""
           }
           set{
               _email = newValue
           }
       }
    
    var template: String {
        get {
            return _template ?? ""
        }
        set {
            _template = newValue
        }
    }
       
}
