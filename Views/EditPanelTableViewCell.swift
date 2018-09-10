//
//  EditPanelTableViewCell.swift
//  Neonsight
//
//  Created by Max Surgai on 07.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class EditPanelTableViewCell: UITableViewCell {

    public var editTool: EditTool! {
        didSet{
            nameLabel.text = editTool.name
            valueLabel.text = "\(editTool.value)"
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        nameLabel.text = editTool.name
//        valueLabel.text = "\(editTool.value)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
