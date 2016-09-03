//
//  ContainerView.swift
//  PilaCollectionView
//
//  Created by Aleix Baggerman on 3/9/16.
//  Copyright © 2016 Aleix Baggerman. All rights reserved.
//

import UIKit

class ContainerView: UIView {

    var firstPoint:CGPoint!
    var secondPoint:CGPoint!
    var thirdPoint:CGPoint!
    var fourthPoint:CGPoint!
    var initialPositon:CGPoint!
    
    var beizerPath = UIBezierPath()
    
    init(initialPosition: CGPoint, width: CGFloat, height: CGFloat){
        super.init(frame: CGRect(x: initialPosition.x, y: initialPosition.y, width: width, height: height))
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
        createPoints()
        beizerPath.moveToPoint(firstPoint)
        beizerPath.addLineToPoint(secondPoint)
        beizerPath.addLineToPoint(thirdPoint)
        beizerPath.addLineToPoint(fourthPoint)
        beizerPath.lineWidth = 3
        beizerPath.stroke()
    }
    
    func createPoints() {
        firstPoint = CGPoint(x: 0.5, y: 0)
        secondPoint = CGPoint(x: 0.5, y: CGRectGetHeight(self.frame)-1)
        thirdPoint = CGPoint(x: CGRectGetWidth(self.frame)-1, y: CGRectGetHeight(self.frame)-1)
        fourthPoint = CGPoint(x: CGRectGetWidth(self.frame)-1, y: 0)
    }

}
