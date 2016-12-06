//
//  ACOverallTools.swift
//  AirChat
//
//  Created by Hancock on 2016/10/9.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

/*
 *这里是工具扩展类
 */

import Foundation
import UIKit

extension UIImage{
    /**
     获取图片中的像素颜色值
     
     - parameter pos: 图片中的位置
     
     - returns: 颜色值
     */
    public func getPixelColor(pos:CGPoint)->(UIColor){
        let pixelData=self.cgImage!.dataProvider!.data
        let data:UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor.init(red: r, green: g, blue: b, alpha: a) 
    }
}


extension ACResideRootVC{
    static var sharedResideRootVC:ACResideRootVC{
        set{
            
        }
        get{
            return self.sharedResideRootVC
        }
    }
}


extension UIViewController{
    func setTabBarVisible(visible:Bool, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBarController?.tabBar.frame
        let offsetY = (visible ? CGFloat(0) : 49.0)
        let duration:TimeInterval = (animated ? 0.3 : 0.0)
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY)
                return
            }
        }
    }
    
    func tabBarIsVisible() ->Bool {
        return (self.tabBarController?.tabBar.frame.origin.y)! < self.view.frame.maxY
    }
    
    
    func setNavBarVisible(visible:Bool, animated:Bool) {
        if (navBarIsVisible() == visible) { return }
        let frame = self.navigationController?.navigationBar.frame
        let offsetY = (visible ? CGFloat(0) : -64.0)
        let duration:TimeInterval = (animated ? 0.3 : 0.0)
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.navigationController?.navigationBar.frame = frame!.offsetBy(dx: 0, dy: offsetY)
                return
            }
        }
    }
    
    func navBarIsVisible() ->Bool {
        return (self.navigationController?.navigationBar.frame.origin.y)! > UIScreen.main.bounds.minY
    }
}
