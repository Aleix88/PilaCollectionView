//
//  ContainerShape.swift
//  PathAnimation
//
//  Created by Aleix Baggerman on 5/9/16.
//  Copyright © 2016 Aleix Baggerman. All rights reserved.
//

import UIKit

class ContainerLayer: CAShapeLayer {
    
    let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    init(path: CGPath) {
        super.init()
        self.path = path
        pathAnimation.duration = 2
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.repeatCount = 1
        pathAnimation.autoreverses = false
        self.strokeColor = UIColor.blackColor().CGColor
        self.fillColor = UIColor.clearColor().CGColor
        self.lineWidth = 4
        self.addAnimation(pathAnimation, forKey: "strokeEnd")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
