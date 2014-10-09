//
//  MyCollectionViewController.swift
//  PagingStarting
//
//  Created by suisho on 2014/10/07.
//  Copyright (c) 2014年 suisho. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class MyLayout : UICollectionViewFlowLayout{
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        //return CGPoint(x: 100,y: 0)
        if let proposedRect = self.collectionView?.bounds{
            let attrs = self.layoutAttributesForElementsInRect(proposedRect) as? [UICollectionViewLayoutAttributes] ?? []
            for at in attrs{
                let kind = at.representedElementKind ?? ""
                switch kind{
                case UICollectionElementKindSectionHeader:
                    println("header")
                    return CGPoint(x: 0, y: 0)
                default:
                    break
                }
            }
            
        }

        return proposedContentOffset
    }
}

class MyCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 10
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        //println(cell)
        // Configure the cell
        let h = CGFloat( arc4random() % 256 / 256)
        cell.backgroundColor = UIColor(hue: h, saturation: CGFloat(0.5), brightness: CGFloat(0.5), alpha: 1.0)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String?, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if let k = kind{
            switch k{
            case UICollectionElementKindSectionHeader:
                return collectionView.dequeueReusableSupplementaryViewOfKind(k, withReuseIdentifier: "Header", forIndexPath: indexPath) as UICollectionReusableView
            default:
                break;
            }
        }
        return UICollectionReusableView()
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    func collectionView(collectionView: UICollectionView!, shouldHighlightItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    func collectionView(collectionView: UICollectionView!, shouldSelectItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    func collectionView(collectionView: UICollectionView!, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView!, canPerformAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) -> Bool {
        return false
    }

    func collectionView(collectionView: UICollectionView!, performAction action: String!, forItemAtIndexPath indexPath: NSIndexPath!, withSender sender: AnyObject!) {
    
    }
    */

}
