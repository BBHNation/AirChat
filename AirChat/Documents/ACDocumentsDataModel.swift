//
//  ACDocumentsDataModel.swift
//  AirChat
//
//  Created by Hancock on 2016/12/5.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import Photos
import Contacts

class ACDocumentsDataModel: NSObject, PHPhotoLibraryChangeObserver{
    static let sharedDataModel = ACDocumentsDataModel() // 单例模式
    dynamic var allPhotos : PHFetchResult<PHAsset> // 存储全部的图片
    dynamic var allVedios : PHFetchResult<PHAsset> // 存储全部的视频
    var contactStore : CNContactStore // 获取contact的API
    dynamic var contactsArray : NSMutableArray // 存储全部的联系人
    
    
    
    /// 初始化信息
    override init() {
        allPhotos = PHFetchResult()
        allVedios = PHFetchResult()
        contactStore = CNContactStore()
        contactsArray = NSMutableArray()
    }
    
    /// 获取本机所有的图片数据
    func getAllPhtotos() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: options)
        self.willChangeValue(forKey: "allPhotos")
        self.didChangeValue(forKey: "allPhotos")
    }
    
    /// 获取本机所有的视频数据
    func getAllVedios() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allVedios = PHAsset.fetchAssets(with: PHAssetMediaType.video, options: options)
        self.willChangeValue(forKey: "allVedios")
        self.didChangeValue(forKey: "allVedios")
    }
    
    
    
    /// 获取本机所有的联系人数据，存储到contactArray中
    func getAllContact() {
        contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: {
            (granted:Bool, error:Error?) in
            if granted {
                //获取成功
                print("获取成功")
                let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor,CNContactFamilyNameKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor,CNContactJobTitleKey as CNKeyDescriptor])
                do{
                    //开始添加数据到数组中，这里iOS自动多次循环
                    try self.contactStore.enumerateContacts(with: request, usingBlock: { (contact, _) in
                        self.contactsArray.add(contact)
                    })
                    self.willChangeValue(forKey: "contactsArray")
                    self.didChangeValue(forKey: "contactsArray")
                } catch {
                }
            }else {
                print("获取失败")
            }
        })
    }
    
    
    
    
    /// 当本机图库发生变化时候调用，重新获取数据
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        getAllPhtotos()
        getAllVedios()
    }
    
}
