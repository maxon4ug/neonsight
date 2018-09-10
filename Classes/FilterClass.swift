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
    
    
    static let filterList = [
        Filter(name: "Sakura I", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "Sakura II", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "Sakura III", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "Sakura IV", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "Sakura V", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "Sakura VI", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "Sakura VII", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "Sakura VIII", image: nil, editToolSettings: [
            EditTool(name: "Exposure", value: 33.0),
            EditTool(name: "Contrast", value: -3.0),
            EditTool(name: "Fade", value: 1.0)
            ]),
        Filter(name: "Sakura IX", image: nil, editToolSettings: [
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
