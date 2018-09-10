//
//  CustomCollectionViewFlowLayout.swift
//  Neonsight
//
//  Created by Max Surgai on 10.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewLayout {

    let cellSpacing:CGFloat = 5
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElements(in: rect) {
            for (index, attribute) in attributes.enumerated() {
                if index == 0 { continue }
                let prevLayoutAttributes = attributes[index - 1]
                let origin = prevLayoutAttributes.frame.maxX
                if(origin + cellSpacing + attribute.frame.size.width < self.collectionViewContentSize.width) {
                    attribute.frame.origin.x = origin + cellSpacing
                }
            }
            return attributes
        }
        return nil
    }
}
