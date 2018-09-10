//
//  FilterClass.swift
//  Neonsight
//
//  Created by Max Surgai on 10.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class Filter {
    
    // MARK: - Properties
    
    let name: String
    let image: UIImage?
    let editToolSettings: [EditTool]
    
    
    static let filterList: [Filter] = [
        Filter(name: "1", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "2", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "3", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        ]
    
    
    // MARK: - Methods
    
    init(name: String, image: UIImage?, editToolSettings: [EditTool]) {
        self.name = name
        self.image = image
        self.editToolSettings = editToolSettings
    }
    
}
