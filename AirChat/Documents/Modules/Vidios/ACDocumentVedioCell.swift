//
//  ACDocumentVedioCell.swift
//  AirChat
//
//  Created by Hancock on 2016/12/21.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import Photos

typealias shareFuncBlock = (_ progress:Progress)->Void

class ACDocumentVedioCell: UITableViewCell {

    var vedioAsset:PHAsset?
    var shareActionBloc:shareFuncBlock?
    
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
                let progress = ACConnectyModel.sharedModel.sendFileWith(url: avurlAsset.url)
                self.shareActionBloc!(progress)
            })
        }
    }

}
