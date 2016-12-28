//
//  ACVisitingCardCollectionViewCell.swift
//  AirChat
//
//  Created by Hancock on 2016/10/10.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit


/// 这里是名片CollectionView的自定义Cell
class ACVisitingCardCollectionViewCell: UICollectionViewCell {
    
    
    /// 针对一个Cell保存数据的Model
    var cellModel:ACVisitingCardCellModel!{
        didSet{
            self.nameLabel.text = cellModel.name
            self.phoneNumLabel.text = cellModel.phone
            self.cardBackImage.image = cellModel.backImage
            self.cardMostColor = cellModel.backImageMostColor
        }
    }
    
    /// 名片的主要颜色
    var cardMostColor:UIColor!
    
    /// 名片的姓名
    @IBOutlet weak var nameLabel: UILabel!
    
    /// 名片的电话号码
    @IBOutlet weak var phoneNumLabel: UILabel!
    
    /// 名片的背景图片
    @IBOutlet weak var cardBackImage: UIImageView! {
        didSet{
            cardBackImage.layer.shadowColor = UIColor.black.cgColor
            cardBackImage.layer.shadowOpacity = 1
            cardBackImage.layer.shadowOffset = CGSize.init(width: 3, height: 3)
            cardBackImage.layer.cornerRadius = 10
        }
    }
    
    
    
    /// 从Nib唤起的时候
    override func awakeFromNib() {
        self.nameLabel.layer.cornerRadius = 5;
        self.nameLabel.layer.masksToBounds = true;
        self.phoneNumLabel.layer.cornerRadius = 5;
        self.phoneNumLabel.layer.masksToBounds = true;
    }
    
    
    /// 初始化产生一个全为空的Cell，这个Cell作为第一个和最后一个Cell
    ///
    /// - returns: 含有空数据的Cell
    public func initOfNil()->ACVisitingCardCollectionViewCell{
        let cell = ACVisitingCardCollectionViewCell()
        cell.nameLabel.text = ""
        cell.phoneNumLabel.text = ""
        return cell
    }
}
