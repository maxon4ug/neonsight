//
//  EditPanelTableViewCell.swift
//  Neonsight
//
//  Created by Max Surgai on 07.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class EditToolTableViewCell: UITableViewCell {

    public var editTool: EditTool! {
        didSet{
            nameLabel.text = editTool.name
            valueLabel.text = self.editTool.value <= 0 ? "\(Int(editTool.value))" : "+\(Int(editTool.value))"
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
