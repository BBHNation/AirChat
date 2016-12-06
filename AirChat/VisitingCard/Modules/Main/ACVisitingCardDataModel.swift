//
//  ACVisitingCardDataModel.swift
//  AirChat
//
//  Created by Hancock on 2016/10/12.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACVisitingCardCellModel: NSObject {
    /// Cell的背景图片
    public var backImage:UIImage!
    /// 背景图片的主色调
    public var backImageMostColor:UIColor?
    /// 名片姓名
    public var name:String!
    /// 名片电话号码
    public var phone:String!
    
    
    /// 初始化一个空的CellModel，充当第一个和最后一个Cell
    ///
    /// - returns: ACVisitingCardCellModel类对象
    public static func initWithNil() -> ACVisitingCardCellModel{
        let cellModel = ACVisitingCardCellModel()
        cellModel.name = ""
        cellModel.phone = ""
        return cellModel
    }
}


class ACVisitingCardDataModel: NSObject {
    var cardCellArray:NSMutableArray!
    var error:NSError?
    
    
    
    /// 这里是初始化函数，建立了一些测试数据
    ///
    /// - returns: 返回ACVisitingCardDataModel类对象
    override init(){
        self.cardCellArray = NSMutableArray()
        
//        cardCellArray.add(ACVisitingCardCellModel.initWithNil())
        for i in 0...20 {
            let cardCell:ACVisitingCardCellModel = ACVisitingCardCellModel()
            switch i%4 {
            case 0:
                cardCell.name = "Binhan Bai"
                cardCell.phone = "86 15882271513"
                cardCell.backImage = UIImage.init(named: "testBack\(arc4random()%4)")
                
            case 1:
                cardCell.backImage = UIImage.init(named: "testBack\(arc4random()%4)")
                cardCell.name = "Qiqi Ran"
                cardCell.phone = "86 15882274710"
                
            case 2:
                cardCell.backImage = UIImage.init(named: "testBack\(arc4random()%4)")
                cardCell.name = "Philips"
                cardCell.phone = "86 15882274710"
                
            case 3:
                cardCell.backImage = UIImage.init(named: "testBack\(arc4random()%4)")
                cardCell.name = "Philips"
                cardCell.phone = "86 15882274710"
            default:
                break
            }
            DispatchQueue.global().async {
                cardCell.backImageMostColor = cardCell.backImage.mostColor()
            }
            self.cardCellArray.add(cardCell)
        }
        cardCellArray.add(ACVisitingCardCellModel.initWithNil())
    }
}



