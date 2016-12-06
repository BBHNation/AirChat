//
//  ACDocumentsDataModel.swift
//  AirChat
//
//  Created by Hancock on 2016/12/5.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import Photos

class ACDocumentsDataModel: NSObject, PHPhotoLibraryChangeObserver{
    static let sharedDataModel = ACDocumentsDataModel()
    var allPhotos : PHFetchResult<PHAsset>
    var allVedios : PHFetchResult<PHAsset>
    
    
    override init() {
        allPhotos = PHFetchResult()
        allVedios = PHFetchResult()
    }
    
    func getAllPhtotos() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: options)
    }
    
    func getAllVedios() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allVedios = PHAsset.fetchAssets(with: PHAssetMediaType.video, options: options)
    }
    
    
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        getAllPhtotos()
        getAllVedios()
    }
    
}
