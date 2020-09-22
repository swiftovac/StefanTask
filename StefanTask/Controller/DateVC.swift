//
//  DateVC.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 04/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import UIKit

protocol DateDelegate {
    func dateSeted(date: Date,row: Int, dateForPickupDetails: Bool)
}

class DateVC: UIViewController {
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DateDelegate?
    var row: Int?
    var dateForPickupDetails: Bool?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.layer.cornerRadius = 12.0
        pickerView.clipsToBounds = true
    }
    

    @IBAction func setDateTapped(_ sender: UIButton) {
        delegate?.dateSeted(date: datePicker.date, row: row!, dateForPickupDetails: dateForPickupDetails!)
        dismiss(animated: true, completion: nil)
    }
    

}
