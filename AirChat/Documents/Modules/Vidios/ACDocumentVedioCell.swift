//
//  ACDocumentVedioCell.swift
//  AirChat
//
//  Created by Hancock on 2016/12/21.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import Photos

class ACDocumentVedioCell: UITableViewCell {

    var vedioAsset:PHAsset?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func shareAction(_ sender: Any) {
        if (vedioAsset != nil) {
            PHCachingImageManager.default().requestAVAsset(forVideo: vedioAsset!, options: nil, resultHandler: { (asset, audioMix, _) in
                let avurlAsset = asset as! AVURLAsset
                ACConnectyModel.sharedModel.sendFileWith(url: avurlAsset.url)
            })
        }
    }

}
