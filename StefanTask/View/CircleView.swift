//
//  CircleView.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 11/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import UIKit

class CircleView: UIView {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.frame.size.width / 2.0
        self.clipsToBounds = true
    }


}
