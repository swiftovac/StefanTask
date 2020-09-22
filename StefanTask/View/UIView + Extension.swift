//
//  UIView + Extension.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 03/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//


import Foundation
import UIKit

extension UIView {


    func setGradientBackgroundColor(colorOne: CGColor, colorTwo: CGColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne,colorTwo]
        gradientLayer.locations = [0,1]
        gradientLayer.startPoint = CGPoint(x:0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y:1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func roundCornersOfView(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

