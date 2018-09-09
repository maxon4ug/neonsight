//
//  UIVIewExtensions.swift
//  Neonsight
//
//  Created by Max Surgai on 09.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
}
