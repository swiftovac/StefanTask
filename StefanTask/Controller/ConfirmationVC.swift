//
//  ConfirmationVC.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 11/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import UIKit

class ConfirmationVC: UIViewController {
    @IBOutlet weak var orderIdView: UIView!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var printBarcodeView: UIView!
    @IBOutlet weak var printDeliveryPageView: UIView!
    
    @IBOutlet weak var downloadPDFView: UIView!
    
    var orderID: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLookForViews(views: [orderIdView,printBarcodeView,printDeliveryPageView,downloadPDFView])
        guard let orderID = orderID else {return}
        orderIdLabel.text = orderID
    }
    
    
    // MARK: - My Functions
    
    func setupLookForViews(views: [UIView]) {
        for view in views {
            view.roundCornersOfView(radius: 8.0)
        }
    }
    
}
