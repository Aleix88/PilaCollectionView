//
//  StackLayout.swift
//  PilaCollectionView
//
//  Created by Aleix Baggerman on 28/8/16.
//  Copyright © 2016 Aleix Baggerman. All rights reserved.
//

import UIKit

protocol StackDelegate {
    
    func setButtonsState()->Bool
    func getViewWidth()->CGFloat
}

class StackLayout: UICollectionViewLayout {
    
    var delegate: StackDelegate!
    
    var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.right + insets.left)
    }
    var contentHeight: CGFloat = 0.0
    var cache = [UICollectionViewLayoutAttributes]()
    var initialAttribute = UICollectionViewLayoutAttributes()
    var finalAttribute = UICollectionViewLayoutAttributes()

    let cellPadding: CGFloat = 20
    
    override func prepareLayout() {
        let numberOfItems = collectionView!.numberOfItemsInSection(0)
        var yOffSet = [CGFloat](count: numberOfItems + 1, repeatedValue: cellPadding)
        let xOffSet : CGFloat! = CGRectGetWidth(collectionView!.frame)/2
        contentHeight = CGRectGetHeight(collectionView!.frame)

        if cache.count > 0 {
            finalAttribute.frame = CGRect(x: delegate.getViewWidth(), y: cache[0].frame.origin.y, width: CGRectGetWidth(cache[0].frame), height: CGRectGetHeight(cache[0].frame))
        }
        
        for i in 0 ..< numberOfItems {
            if i == 0 {
                cache = [UICollectionViewLayoutAttributes]()
            }
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            let stackHeight: CGFloat = (contentHeight) - (cellPadding * (CGFloat(numberOfItems) + 1))
            let elementHeight = stackHeight/CGFloat(numberOfItems)
            let width: CGFloat = CGRectGetWidth(collectionView!.bounds)/1.2
            let frame = CGRect(x: xOffSet, y: yOffSet[i], width: width, height: elementHeight)
            attribute.frame = frame
            attribute.center = CGPoint(x: xOffSet, y: attribute.center.y)
            
            cache.append(attribute)
            initialAttribute.frame = CGRect(x: cache[0].frame.origin.x, y: cache[0].frame.origin.y, width: 0, height: 0)
            yOffSet[i + 1] = yOffSet[i] + elementHeight + cellPadding
        }
        
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if collectionView!.numberOfItemsInSection(0)==0{
            return nil
        }else{
            return cache
        }
    }
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        if itemIndexPath.row == 0 && delegate.setButtonsState() == true  {
            return initialAttribute
        }
        return nil
    }
    
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
      
        if itemIndexPath.row == 0 && delegate.setButtonsState() == false {
            return finalAttribute
        }
        return nil
    }
}
