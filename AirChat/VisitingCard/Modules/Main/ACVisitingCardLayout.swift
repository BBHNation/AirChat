//
//  ACVisitingCardLayout.swift
//  AirChat
//
//  Created by Hancock on 2016/10/9.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACVisitingCardLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        self.itemSize = CGSize.init(width: UIScreen.main.bounds.size.width-20, height: UIScreen.main.bounds.size.width*0.5)
        self.scrollDirection = UICollectionViewScrollDirection.vertical
        self.minimumLineSpacing = 5.0
        self.collectionView?.showsVerticalScrollIndicator = false
    }

    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let array = super.layoutAttributesForElements(in: rect)
//        let centetY = (self.collectionView?.contentOffset.y)! + UIScreen.main.bounds.size.width*0.5
        let centetY = (self.collectionView?.contentOffset.y)! + (self.collectionView?.frame.height)!/2
        
        for attrs:UICollectionViewLayoutAttributes in array! {
            
            let delta = abs(attrs.center.y - centetY)//相对于collectionView中心点的偏移量
            if delta<30 {
                let row = ((self.collectionView?.contentOffset.y)! + 64)/self.itemSize.height
                let introw = Int(row) + 1
                print("delta is: +  \(delta) + introw is: + \(introw) contentOffset is: \(self.collectionView?.contentOffset.y) row is: \(row)")
                
                let rowcell:ACVisitingCardCollectionViewCell? = self.collectionView!.cellForItem(at: NSIndexPath.init(row: introw, section: 0) as IndexPath) as? ACVisitingCardCollectionViewCell
                if (rowcell != nil){
                    UIView.animate(withDuration: 0.5, animations: {
                        self.collectionView?.backgroundColor = rowcell?.cardMostColor
                    })
                }
            }
            let scale = 1 - (delta*0.7)/(self.collectionView?.frame.size.height)!
            attrs.transform = CGAffineTransform.init(scaleX: scale, y: scale)
        }
        return array;
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
}
