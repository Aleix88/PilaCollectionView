//
//  StackViewController.swift
//  PilaCollectionView
//
//  Created by Aleix Baggerman on 28/8/16.
//  Copyright © 2016 Aleix Baggerman. All rights reserved.
//

import UIKit

let cellIdentifier = "Stack"
var numberOfElements = 0
var addCell = true
var initialPositon:CGPoint!
var width:CGFloat!
var height:CGFloat!
var containerView:ContainerView!

class StackViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (collectionView.collectionViewLayout as! StackLayout).delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        setContainerPoints()
        containerView = ContainerView(initialPosition:initialPositon, width: width, height: height)
        self.view.addSubview(containerView)

    }
    
    func setContainerPoints() {
        width = CGRectGetWidth(collectionView!.bounds)
        height = CGRectGetHeight(collectionView!.frame)
        initialPositon = CGPoint(x: collectionView!.frame.origin.x, y: collectionView!.frame.origin.y)
    }

    @IBAction func addElement(sender: UIButton) {
            addCell = true
            numberOfElements += 1
            collectionView.insertItemsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)])
    }
    
    @IBAction func removeElement(sender: UIButton) {
        addCell = false
        if numberOfElements > 0 {
            numberOfElements -= 1
            collectionView.deleteItemsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)])
        }
    }
}

extension StackViewController: UICollectionViewDataSource {

    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfElements
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = getRandomColor()
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.blackColor().CGColor
        return cell
    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

extension StackViewController: StackDelegate {

    func setButtonsState() -> Bool {
        return addCell
    }
    
    func getViewWidth() -> CGFloat {
        return CGRectGetWidth(self.view.frame)
    }
    
}
