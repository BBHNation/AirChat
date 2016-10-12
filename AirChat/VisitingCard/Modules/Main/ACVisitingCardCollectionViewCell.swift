//
//  ACVisitingCardCollectionViewCell.swift
//  AirChat
//
//  Created by Hancock on 2016/10/10.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACVisitingCardCollectionViewCell: UICollectionViewCell {
    var cardMostColor:UIColor! 
    @IBOutlet weak var cardBackImage: UIImageView! {
        didSet{
            cardBackImage.layer.shadowColor = UIColor.black.cgColor
            cardBackImage.layer.shadowOpacity = 1
            cardBackImage.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        }
    }
}
