//
//  UITextField + Extension.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 09/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import Foundation
import UIKit


extension UITextField{

       @IBInspectable var doneAccessory: Bool{

        get{

            return self.doneAccessory

        }

        set (hasDone) {

            if hasDone{

                addDoneButtonOnKeyboard()

            }

        }

    }
    
    func addDoneButtonOnKeyboard()

    {

        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))

        doneToolbar.barStyle = .default

        

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]

        doneToolbar.items = items

        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar

    }
    @objc func doneButtonAction()

    {

    self.resignFirstResponder()

    }

}
