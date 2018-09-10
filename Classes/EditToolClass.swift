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
    
    let name: String
    var value: Double
    let defaultValue: Double
    let maxValue: Double
    let minValue: Double
    
    
    // MARK: - Methods
    
    init(name: String, value: Double, maxValue: Double, minValue: Double) {
        self.name = name
        self.value = value
        self.defaultValue = value
        self.maxValue = maxValue
        self.minValue = minValue
    }
    
    //
    init(name: String, value: Double) {
        self.name = name
        self.value = value
        self.defaultValue = 0
        self.maxValue = 0
        self.minValue = 0
    }
    
    //
    public func clearValue() {
        value = defaultValue
    }
}
