//
//  TemplateVC.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 09/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import UIKit

protocol TemplateDelegate {
    func templateSeted(template: String, row: Int)
}

class TemplateVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    var pickedTemplate: String?
    
    var delegate: TemplateDelegate?
    var row: Int?
    
    var templates = ["Template 1", "Template 2", "Template 3", "Template 4", "Template 5"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerContainerView.layer.cornerRadius = 12.0
            pickerContainerView.clipsToBounds = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectedRow(inComponent: 0)
        
        
        
    }
    

    @IBAction func setTemplateButtonTapped(_ sender: UIButton) {
        delegate?.templateSeted(template: pickedTemplate ?? "Template 1", row: row!)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return templates.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = templates[row]
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedTemplate = templates[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    
    

}
