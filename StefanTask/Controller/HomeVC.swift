//
//  ViewController.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 02/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeOrderButton: UIButton!
    
    private let database = Database.database().reference()
    var order = Order()
    var pickupCellSelectedRowIndex:Int = -1
    var pickupDetailsCellTapped: Bool = false
    var deliveryCellSelectedRowIndex = -1
    var deliveryDetailsCellTapped: Bool = false
    var indexPath: IndexPath!
    var setedTemplate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(self.showFinish))
        
        navigationItem.leftBarButtonItem = leftBarButton
        
        setupPlaceOrderBtnLook(button: placeOrderButton)
        
        tableView.register(UINib(nibName: "PickupDetailsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "pickupDetailsCell")
        tableView.register(UINib(nibName: "NotesCell", bundle: nil), forCellReuseIdentifier: "notesCell")
        tableView.register(UINib(nibName: "DeliveryDetailsCell", bundle: nil), forCellReuseIdentifier: "deliveryDetailsCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @objc func showFinish() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let confirmationVC = storyboard.instantiateViewController(withIdentifier: "confirmationVC") as! ConfirmationVC
        confirmationVC.modalPresentationStyle = .fullScreen
        present(confirmationVC, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func placeOrderButtonTapped(_ sender: UIButton) {
        let orderID = "\(Int.random(in: 0..<9999999))"
        let orderKey = "order\(orderID)"
        let databaseMain = database.child("\(orderKey)")
        
        saveOrderToDatabase(orderID:orderID,orderKey: orderKey, dbRef: databaseMain, pickupDetails: order.pickupDetails, deliveryDetails: order.deliveryDetails)
    }
    
    // MARK: - My Functions
    
    
    func saveOrderToDatabase(orderID: String,orderKey: String,dbRef: DatabaseReference, pickupDetails: [PickupDetails], deliveryDetails: [DeliveryDetails]) {
                
        // save all pickupDetails
        for index in 0..<pickupDetails.count {
            let pickupDetails = pickupDetails[index]
            let pickDet: [String: String] = [
                "address":"\(pickupDetails.pickupAddress)",
                "name":"\(pickupDetails.name)",
                "phoneNumber":"\(pickupDetails.phoneNumber)",
                "date":"\(pickupDetails.pickupDate)",
                "rxNumber":"\(pickupDetails.rxNumber)"
            ]
                
            dbRef.child("pickupDetails").child("pickupDetail\(index)").setValue(pickDet)
            
        }
        
        // save all deliveryDetails
        for index in 0..<deliveryDetails.count {
            let deliveryDetails = deliveryDetails[index]
            let delDet: [String: String] = [
                "address":"\(deliveryDetails.pickupAddress)",
                "name":"\(deliveryDetails.name)",
                "phoneNumber":"\(deliveryDetails.phoneNumber)",
                "date":"\(deliveryDetails.pickupDate)",
                "email":"\(deliveryDetails.email)",
                "template":"\(deliveryDetails.template)"
                
            ]
            
            
            dbRef.child("deliveryDetails").child("deliveryDetail\(index)").setValue(delDet)
        }
        
        // save order note
        let orderNote = "\(order.note)"
        
        dbRef.child("orderNote").setValue(orderNote) {(err: Error?, ref: DatabaseReference) in
            
            if let err = err {
                print("Data could not be saved \(err)")
                
            }else {
                print("Data is saved")
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let confirmationVC = storyboard.instantiateViewController(withIdentifier: "confirmationVC") as! ConfirmationVC
                confirmationVC.orderID = orderID
                
                confirmationVC.modalPresentationStyle = .fullScreen
                
                self.present(confirmationVC, animated: true, completion: nil)
            }
            
        }
    }

    func setupPlaceOrderBtnLook(button: UIButton) {
        button.setGradientBackgroundColor(colorOne: Colors.firstColor, colorTwo: Colors.secondColor)
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        
    }
    
    func setupCellLook(cell: PickupDetailsCellTableViewCell, buttonTitle: String) {
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.contentView.layer.cornerRadius = 8.0
        cell.contentView.clipsToBounds = true
        cell.selectionStyle = .none
        cell.delegate = self
        cell.addButton.setTitle(buttonTitle, for: .normal)
        
        
    }
    
    func setupDeliveryCellLook(cell: DeliveryDetailsCell, buttonTitle: String) {
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.contentView.layer.cornerRadius = 8.0
        cell.contentView.clipsToBounds = true
        cell.selectionStyle = .none
        cell.delegate = self
        cell.deliveryDetailsAddButton.setTitle(buttonTitle, for: .normal)
        
    }
    
    
    // MARK: - TableView Delegate & Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return order.pickupDetails.count
            
        }else if section == 1 {
            return order.deliveryDetails.count
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pickupDetailsCell", for: indexPath) as! PickupDetailsCellTableViewCell
            
            let pickupDetails = order.pickupDetails[indexPath.row]
            cell.configureCellWIthPickupDetails(pickupDetails: pickupDetails)
            setupCellLook(cell: cell, buttonTitle: "Remove")
            return cell
            
        }else if indexPath.section == 1  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryDetailsCell", for: indexPath) as! DeliveryDetailsCell
            setupDeliveryCellLook(cell: cell, buttonTitle: "Remove")
            let deliveryDetails = order.deliveryDetails[indexPath.row]
            cell.configureDeliveryDetailsCell(deliveryDetails: deliveryDetails)
            return cell
        }
            
        else if indexPath.section == 2  && indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesCell
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.contentView.layer.cornerRadius = 8.0
            cell.contentView.clipsToBounds = true
            cell.selectionStyle = .none
            return cell
            
        }else if indexPath.section == 2  && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryDetailsCell", for: indexPath) as! DeliveryDetailsCell
            setupDeliveryCellLook(cell: cell, buttonTitle: "Add")
            return cell
            
        }else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pickupDetailsCell", for: indexPath) as! PickupDetailsCellTableViewCell
            setupCellLook(cell: cell, buttonTitle: "Add")
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if indexPath.row == pickupCellSelectedRowIndex && pickupDetailsCellTapped {
                return 385.0
            }else if indexPath.row == order.pickupDetails.count - 1 {
                return 385.0
            }
            else{
                return 60.0
            }
        }
        else if indexPath.section == 1 {
            
            if indexPath.row == deliveryCellSelectedRowIndex && deliveryDetailsCellTapped {
                return 509.0
            }else if indexPath.row == order.deliveryDetails.count - 1 {
                return 509.0
            }else {
                return 60.0
            }
        }
        else {
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == tableView.numberOfRows(inSection: 2) - 1 {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let addNoteVC = storyboard.instantiateViewController(withIdentifier: "addNoteVC") as! AddNoteVC
            addNoteVC.delegate = self
            present(addNoteVC, animated: true, completion: nil)
        }
        
        if indexPath.section == 0 {
            
            if pickupCellSelectedRowIndex != indexPath.row  && indexPath.row != order.pickupDetails.count - 1 {
                self.pickupCellSelectedRowIndex = indexPath.row
                self.pickupDetailsCellTapped = true
            }else {
                
                self.pickupCellSelectedRowIndex = -1
                self.pickupDetailsCellTapped = false
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        if indexPath.section == 1 {
            
            if deliveryCellSelectedRowIndex != indexPath.row  && indexPath.row != order.deliveryDetails.count - 1 {
                self.deliveryCellSelectedRowIndex = indexPath.row
                self.deliveryDetailsCellTapped = true
            }else {
                
                self.deliveryCellSelectedRowIndex = -1
                self.deliveryDetailsCellTapped = false
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
    }
}

// MARK: - PickupCellDelegate

extension HomeVC: PickupCellDelegate {
    
    
    
    func formFilled(address: String, name: String, phoneNumber: String, reNumber: String, cell: PickupDetailsCellTableViewCell) {
        
        let indexPath = tableView.indexPath(for: cell)
        let row = indexPath?.row
        if row != nil {
            
            let pickupDetails = order.pickupDetails[row!]
            pickupDetails.pickupAddress = address
            pickupDetails.name = name
            pickupDetails.phoneNumber = phoneNumber
            pickupDetails.rxNumber = reNumber
        }
    }
    
    func calendarButtonTapped(cell: PickupDetailsCellTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let dateVC = storyboard.instantiateViewController(withIdentifier: "dateVC") as! DateVC
        dateVC.delegate = self
        dateVC.dateForPickupDetails = true
        dateVC.row = indexPath?.row
        dateVC.modalPresentationStyle = .overCurrentContext
        present(dateVC, animated: true, completion: nil)
    }
    
    func addButtonTapped(cell: PickupDetailsCellTableViewCell) {
        
        
        indexPath = tableView.indexPath(for: cell)!
        if cell.addButton.title(for: .normal) == "Remove" {
            
            order.pickupDetails.remove(at: indexPath.row)
            DispatchQueue.main.async {
                
                self.tableView.deleteRows(at: [self.indexPath], with: .fade)
            }
            
        }else {
            
            let newPickupDetail = PickupDetails()
            self.order.pickupDetails.append(newPickupDetail)
            
            DispatchQueue.main.async {
                self.tableView.insertRows(at: [IndexPath(row: self.order.pickupDetails.count - 1, section: 0)], with: .automatic)
                
                self.tableView.scrollToRow(at: IndexPath(row: self.order.pickupDetails.count - 1, section: 0), at: .top, animated: true)
            }
        }
    }
    
}

// MARK: - DeliveryCell Delegate

extension HomeVC: DeliveryCellDelegate {
    func deliveryFormFilled(address: String, name: String, phoneNumber: String, email: String,template: String, cell: DeliveryDetailsCell) {
        let indexPath = tableView.indexPath(for: cell)
        let row = indexPath?.row
        if row != nil {
            
            let deliveryDetails = order.deliveryDetails[row!]
            deliveryDetails.pickupAddress = address
            deliveryDetails.name = name
            deliveryDetails.email = email
            deliveryDetails.phoneNumber = phoneNumber
            deliveryDetails.template = template
        }
    }
    func radioButtonTapped(cell: DeliveryDetailsCell) {
        cell.radioButton.layer.borderWidth = 0.0
        
        if cell.radioButton.image(for: .normal) == UIImage(named: "Check") {
            cell.radioButton.setImage(nil, for: .normal)
            cell.templateButton.isEnabled = false
            
        }else {
            cell.radioButton.setImage(UIImage(named: "Check"), for: .normal)
            setedTemplate = "Template 1"
            cell.templateButton.isEnabled = true
            cell.templateNameLabel.text = setedTemplate!
        }
    }
    
    func addDeliveryDetailsButtonTapped(cell: DeliveryDetailsCell) {
        indexPath = tableView.indexPath(for: cell)!
        if cell.deliveryDetailsAddButton.title(for: .normal) == "Remove" {
            
            order.deliveryDetails.remove(at: indexPath.row)
            DispatchQueue.main.async {
                
                self.tableView.deleteRows(at: [self.indexPath], with: .fade)
            }
            
        }else {
            let newDeliveryDetail = DeliveryDetails()
            self.order.deliveryDetails.append(newDeliveryDetail)
            DispatchQueue.main.async {
                self.tableView.insertRows(at: [IndexPath(row: self.order.deliveryDetails.count - 1, section: 1)], with: .automatic)
                
                self.tableView.scrollToRow(at: IndexPath(row: self.order.deliveryDetails.count - 1, section: 1), at: .top, animated: true)
            }
        }
    }
    
    func calendButtonTapped(cell: DeliveryDetailsCell) {
        let indexPath = tableView.indexPath(for: cell)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let dateVC = storyboard.instantiateViewController(withIdentifier: "dateVC") as! DateVC
        dateVC.delegate = self
        dateVC.dateForPickupDetails = false
        dateVC.row = indexPath?.row
        dateVC.modalPresentationStyle = .overCurrentContext
        present(dateVC, animated: true, completion: nil)
    }
    
    func templateButtonTapped(cell: DeliveryDetailsCell) {
        let indexPath = tableView.indexPath(for: cell)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let templateVC = storyboard.instantiateViewController(withIdentifier: "templateVC") as! TemplateVC
        templateVC.row = indexPath?.row
        templateVC.delegate = self
        templateVC.modalPresentationStyle = .overCurrentContext
        present(templateVC, animated: true, completion: nil)
    }
    
}

// MARK: - DateDelegate

extension HomeVC: DateDelegate {
    func dateSeted(date: Date, row: Int, dateForPickupDetails: Bool) {
        if dateForPickupDetails {
            order.pickupDetails[row].pickupDate = date.stringFromDate(date: date)
        }else {
            order.deliveryDetails[row].pickupDate = date.stringFromDate(date: date)
        }
        tableView.reloadData()
    }
    
}


// MARK: - TemplateDelegate

extension HomeVC: TemplateDelegate {
    func templateSeted(template: String, row: Int) {
        setedTemplate = template
        order.deliveryDetails[row].template = setedTemplate!
        tableView.reloadData()
    }
}

// MARK: - NoteDelegate

extension HomeVC: NoteDelegate {
    func noteEntered(note: String) {
        order.note = note
    }
}


// MARK: - Date Extension

extension Date {
    func stringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d, MMM yyyy,h:mm a"
        return dateFormatter.string(from: date)
        
    }
}
