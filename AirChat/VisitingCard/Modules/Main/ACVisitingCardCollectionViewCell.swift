//
//  ACVisitingCardCollectionViewCell.swift
//  AirChat
//
//  Created by Hancock on 2016/10/10.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACVisitingCardCollectionViewCell: UICollectionViewCell {
    
    var cellModel:ACVisitingCardCellModel!{
        didSet{
            self.nameLabel.text = cellModel.name
            self.phoneNumLabel.text = cellModel.phone
            self.cardBackImage.image = cellModel.backImage
            self.cardMostColor = cellModel.backImageMostColor
        }
    }
    var cardMostColor:UIColor!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var cardBackImage: UIImageView! {
        didSet{
            cardBackImage.layer.shadowColor = UIColor.black.cgColor
            cardBackImage.layer.shadowOpacity = 1
            cardBackImage.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        }
    }
    override func awakeFromNib() {
        self.nameLabel.layer.cornerRadius = 5;
        self.nameLabel.layer.masksToBounds = true;
        self.phoneNumLabel.layer.cornerRadius = 5;
        self.phoneNumLabel.layer.masksToBounds = true;
    }
    
    public func initOfNil()->ACVisitingCardCollectionViewCell{
        let cell = ACVisitingCardCollectionViewCell()
        cell.nameLabel.text = ""
        cell.phoneNumLabel.text = ""
        return cell
    }
}
