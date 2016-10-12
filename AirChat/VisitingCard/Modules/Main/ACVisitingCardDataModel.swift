//
//  ACVisitingCardDataModel.swift
//  AirChat
//
//  Created by Hancock on 2016/10/12.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACVisitingCardCellModel: NSObject {
    public var backImage:UIImage!
    public var backImageMostColor:UIColor?
    public var name:String!
    public var phone:String!
    
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
    
    
    override init(){
        self.cardCellArray = NSMutableArray()
        
        cardCellArray.add(ACVisitingCardCellModel.initWithNil())
        for i in 0...20 {
            if i%2==0 {
                let cardCell:ACVisitingCardCellModel = ACVisitingCardCellModel()
                cardCell.name = "Binhan Bai"
                cardCell.phone = "86 15882271513"
                cardCell.backImage = UIImage.init(named: "testBack2")
                DispatchQueue.global().async {
                    cardCell.backImageMostColor = cardCell.backImage.mostColor()
                }
                self.cardCellArray.add(cardCell)
            }
            else{
                let cardCell:ACVisitingCardCellModel = ACVisitingCardCellModel()
                cardCell.backImage = UIImage.init(named: "testBack")
                cardCell.name = "Qiqi Ran"
                cardCell.phone = "86 15882274710"
                DispatchQueue.global().async {
                    cardCell.backImageMostColor = cardCell.backImage.mostColor()
                }
                self.cardCellArray.add(cardCell)
            }
        }
        cardCellArray.add(ACVisitingCardCellModel.initWithNil())
    }
}



