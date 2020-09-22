//
//  NotesCell.swift
//  StefanTask
//
//  Created by Stefan Milenkovic on 04/09/2020.
//  Copyright © 2020 Stefan Milenkovic. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()

          contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
      }
    
}
