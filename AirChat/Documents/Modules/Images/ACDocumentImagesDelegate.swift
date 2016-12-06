//
//  ACDocumentImagesDelegate.swift
//  AirChat
//
//  Created by Hancock on 2016/12/1.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import Photos

class ACDocumentImagesDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACDocumentsDataModel.sharedDataModel.allPhotos.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        
        /*
        let width = UIScreen.main.bounds.size.width/3 - 20
        cell.bounds = CGRect(x: 0, y: 0, width: width, height: width*16/9)
 */
        
        let imageView = cell.viewWithTag(1024) as! UIImageView
        let asset = ACDocumentsDataModel.sharedDataModel.allPhotos[indexPath.row]
        
        /// 这里是通过phasset来获取图片
        
        PHCachingImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 120), contentMode: PHImageContentMode.aspectFill , options: nil, resultHandler: {
            (result : UIImage?, dictionary : Dictionary?) in
            imageView.image = result
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap on \(indexPath)")
    }
}
