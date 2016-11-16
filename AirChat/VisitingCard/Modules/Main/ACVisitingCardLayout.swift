//
//  ACVisitingCardLayout.swift
//  AirChat
//
//  Created by Hancock on 2016/10/9.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit


/// 这里是名片CollectinView的Layout方式
class ACVisitingCardLayout: UICollectionViewFlowLayout {
    
    /// 这个date用来计算时间，如果快速滑动则不会更改名片背景图主要颜色
    var dateBefore:NSDate?
    
    
    /// 准备，初始化Layout
    override func prepare() {
        super.prepare()
        self.itemSize = CGSize.init(width: UIScreen.main.bounds.size.width-20, height: UIScreen.main.bounds.size.width*0.5)
        self.scrollDirection = UICollectionViewScrollDirection.vertical
        self.minimumLineSpacing = 5.0
        self.collectionView?.showsVerticalScrollIndicator = false
    }

    
    /// 自定义布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)
        let centetY = (self.collectionView?.contentOffset.y)! + (self.collectionView?.frame.height)!/2
        for attrs:UICollectionViewLayoutAttributes in array! {
            let delta = abs(attrs.center.y - centetY)//相对于collectionView中心点的偏移量

            let scale = 1 - (delta*0.7)/(self.collectionView?.frame.size.height)!
            attrs.transform = CGAffineTransform.init(scaleX: scale, y: scale)
        }
        return array;
    }
    
    
    
    /// 根据时间来判断何时应该触发block
    func startDoingWhenTimeMoreThan(date:NSDate,action:()->Void) {
        //如果之前调用过此函数并且现在的时间大于之前的时间0.3秒，则调用block，因为滑动过快时候调用动画会阻隔用户手势
        if (self.dateBefore != nil) && (date.timeIntervalSince1970-(self.dateBefore?.timeIntervalSince1970)!>0.3){
            action()
        }
        self.dateBefore = date
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        //计算出最终显示的矩形框
        var rect:CGRect = CGRect()
        rect.origin.x=0
        rect.origin.y = proposedContentOffset.y
        rect.size = (self.collectionView?.frame.size)!
        
        
        //获得size中已经布局好的属性
        let attrs = super.layoutAttributesForElements(in: rect)
        
        //计算collectionView最中心点的Y值
        let centerY = proposedContentOffset.y+(self.collectionView?.frame.size.height)! * 0.5
        
        // 存放最小的间距值
        var minDelta:CGFloat = -1024
        
        //存放cell布局与collectionview中心点的距离
        for attr:UICollectionViewLayoutAttributes in attrs! {
            let delta = abs(attr.center.y-centerY)
            if (minDelta == -1024){
                minDelta = delta+1
            }
            if (abs(minDelta)>delta) {
                minDelta = attr.center.y-centerY
            }
        }
        let resultOffSet:CGPoint = CGPoint.init(x: proposedContentOffset.x, y: proposedContentOffset.y+minDelta)
        
        
        //通过最终的offset来计算当前应该是哪个cell，再设置背景颜色
//        var row = (resultOffSet.y+47.25)/(self.itemSize.height + 5)
        let row = (resultOffSet.y+52.5)/(self.itemSize.height + 5)
        let introw = Int(row)+1
        print("int row is :\(introw) result off set is: \(resultOffSet) row is :\(row) screen is :\(UIScreen.main.bounds) item Size is :\(self.itemSize.height)")
        let rowcell:ACVisitingCardCollectionViewCell? = self.collectionView!.cellForItem(at: NSIndexPath.init(row: introw, section: 0) as IndexPath) as? ACVisitingCardCollectionViewCell
        if (rowcell != nil){
            self.startDoingWhenTimeMoreThan(date: NSDate(), action: {
                UIView.animate(withDuration: 0.2, animations: {
                    self.collectionView?.backgroundColor = rowcell?.cardMostColor
                })
            })
        }
        return resultOffSet
    }
    
    
    /// 每次松手时候计算
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true;
    }
}
