//
//  SelfSizedTableView.swift
//  Neonsight
//
//  Created by Max Surgai on 07.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentSize.height)
    }
}
