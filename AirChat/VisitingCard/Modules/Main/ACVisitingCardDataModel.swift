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
}


class ACVisitingCardDataModel: NSObject {
    var cardCellArray:NSMutableArray!
    var error:NSError?
    
    
    override init(){
        self.cardCellArray = NSMutableArray()
        cardCellArray.add(ACVisitingCardCellModel())
        for i in 0...20 {
            if i%2==0 {
                let cardCell:ACVisitingCardCellModel = ACVisitingCardCellModel()
                cardCell.backImage = UIImage.init(named: "testBack2")
                DispatchQueue.global().async {
                    cardCell.backImageMostColor = cardCell.backImage.mostColor()
                }
                self.cardCellArray.add(cardCell)
            }
            else{
                let cardCell:ACVisitingCardCellModel = ACVisitingCardCellModel()
                cardCell.backImage = UIImage.init(named: "testBack")
                DispatchQueue.global().async {
                    cardCell.backImageMostColor = cardCell.backImage.mostColor()
                }
                self.cardCellArray.add(cardCell)
            }
        }
        cardCellArray.add(ACVisitingCardCellModel())
    }
}



