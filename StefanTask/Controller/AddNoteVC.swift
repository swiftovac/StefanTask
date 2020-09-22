//
//  AddNoteVC.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 03/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import UIKit

protocol NoteDelegate {
    func noteEntered(note: String)
}

class AddNoteVC: UIViewController, UITextViewDelegate {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var symbolsLeftLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var delegate: NoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        

        setupDoneButton(button: doneButton)
        
        
        textField.delegate = self
        textField.text = "Add some note here…"
        textField.textColor = .lightGray
        
        closeButton.layer.cornerRadius = closeButton.frame.size.width / 2.0
        closeButton.clipsToBounds = true
    }
    
    // MARK: - UITextView Delegate
    func textViewDidBeginEditing(_ textField: UITextView) {
        if (textField.text == "Add some note here…" && textField.textColor == .lightGray)
        {
            textField.text = ""
            textField.textColor = .black
        }
        textField.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textField: UITextView)
    {
        if (textField.text == "")
        {
            textField.text = "Add some note here…"
            textField.textColor = .lightGray
        }
        textField.resignFirstResponder()
    }
    
    func textView(_ textField: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return textField.text.count + (text.count - range.length) <= 120
    }
    
    func textViewDidChange(_ textView: UITextView) {
        symbolsLeftLabel.text = "\(120 - textView.text.count) symbols left"
    }
    
    
    // MARK: - Actions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        
        delegate?.noteEntered(note: textField.text)
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - My funcs
    
    // code from figma
    func setupDoneButtonByFigmaCode(doneButton: UIButton) {
        let layer0 = CAGradientLayer()

        layer0.colors = [

          UIColor(red: 0.008, green: 0.478, blue: 1, alpha: 1).cgColor,

          UIColor(red: 0.169, green: 0.875, blue: 0.953, alpha: 1).cgColor

        ]

        layer0.locations = [0, 1]

        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)

        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)

        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 3.63, c: -3.63, d: 1, tx: 0, ty: -1.17))

        layer0.bounds = doneButton.bounds.insetBy(dx: -0.5*doneButton.bounds.size.width, dy: -0.5*doneButton.bounds.size.height)

        layer0.position = doneButton.center

        doneButton.layer.addSublayer(layer0)


        doneButton.layer.cornerRadius = 18
    }
    
    func setupDoneButton(button: UIButton) {
        
        button.layer.cornerRadius = 18.0
        button.clipsToBounds = true
         button.setGradientBackgroundColor(colorOne:Colors.firstColor, colorTwo: Colors.secondColor)
    }
    
}




