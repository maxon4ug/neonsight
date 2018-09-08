//
//  EditPanelTableViewCell.swift
//  Neonsight
//
//  Created by Max Surgai on 07.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class EditPanelTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if nameLabel.text == "" {
            valueLabel.text = ""
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
