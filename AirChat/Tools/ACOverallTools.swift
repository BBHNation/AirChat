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
