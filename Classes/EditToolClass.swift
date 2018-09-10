//
//  EditToolClass.swift
//  Neonsight
//
//  Created by Max Surgai on 10.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class EditTool {
    
    // MARK: - Properties
    
    var name: String
    var value: Double
    var defaultValue: Double
    var maxValue: Double
    var minValue: Double
    
    
    // MARK: - Methods
    
    init(name: String, value: Double, maxValue: Double, minValue: Double) {
        self.name = name
        self.value = value
        self.defaultValue = value
        self.maxValue = maxValue
        self.minValue = minValue
    }
    
    public func clearValue() {
        value = defaultValue
    }
}
