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
    
    /// 返回section中的cell个数，返回所有图片等个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACDocumentsDataModel.sharedDataModel.allPhotos.count
    }
    
    /// 返回section的个数，是一个
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /// 返回一个自定义的Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //重用Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        
        //获取图片
        let imageView = cell.viewWithTag(1024) as! UIImageView
        
        //获取asset，使用asset来获取图片
        let asset = ACDocumentsDataModel.sharedDataModel.allPhotos[indexPath.row]
        
        /// 这里是通过phasset来获取图片
        PHCachingImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 120), contentMode: PHImageContentMode.aspectFill , options: nil, resultHandler: {
            (result : UIImage?, dictionary : Dictionary?) in
            imageView.image = result
        })
        return cell
    }
    
    /// 这里是点击后的操作
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap on \(indexPath)")
    }
}
