//
//  ACDocumentVidiosDelegate.swift
//  AirChat
//
//  Created by Hancock on 2016/12/1.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import Photos
import AVKit
import SVProgressHUD


class ACDocumentVidiosDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    /// 测试window
    var mywindow:UIWindow?
    var rootWindow = UIApplication.shared.keyWindow
    
    
    
    /// 点击播放的操作
    var tapBlock:((_ avplayerItem : AVPlayerItem)->())?
    
    /// 记录操作请求个数
    static var requestCount = 0
    
    /// 存储操作请求
    static let requestArray = NSMutableArray()
    
    var timer:Timer?
    
    
    
    func add() {
        mywindow = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        mywindow?.windowLevel = UIWindowLevelAlert+1
        mywindow?.backgroundColor = UIColor.clear
        mywindow?.makeKeyAndVisible()
    }
    
    func remove() {
        mywindow?.isHidden = true
        mywindow = nil
        rootWindow?.makeKeyAndVisible()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACDocumentsDataModel.sharedDataModel.allVedios.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// 重用Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "VedioCell", for: indexPath) as! ACDocumentVedioCell
        
        /// 传递信息
        cell.vedioAsset = ACDocumentsDataModel.sharedDataModel.allVedios[indexPath.row]
        cell.shareActionBloc = {
            progress in
            tableView.superview?.isUserInteractionEnabled = false
            self.timer = Timer(timeInterval: 1, repeats: true, block: { (timer) in
                print(progress.completedUnitCount*100/progress.totalUnitCount)
                SVProgressHUD.showProgress(Float(progress.completedUnitCount)/Float(progress.totalUnitCount), status: "正在传输中...")
                if (progress.completedUnitCount==progress.totalUnitCount) {
                    SVProgressHUD.showSuccess(withStatus: "传输成功")
                    self.remove()
                    tableView.superview?.isUserInteractionEnabled = true
                    self.timer?.invalidate()
                }
            })
            RunLoop.main.add(self.timer!, forMode: RunLoopMode.commonModes)
            self.add()
        }
        
        /// 获取Cell中的图片
        let cellImage = cell.viewWithTag(1024) as! UIImageView
        cellImage.image = UIImage.init(named: "back")
        
        /// 从视频中获取截图
        let requestId = PHCachingImageManager.default().requestPlayerItem(forVideo: ACDocumentsDataModel.sharedDataModel.allVedios[indexPath.row], options: nil, resultHandler: {
            item, _ in
            if item==nil{
                return
            }
            else{
                let gen = AVAssetImageGenerator(asset: (item?.asset)!)
                let cmTime = CMTime(seconds: 0.0, preferredTimescale: 600)
                let image = try? gen.copyCGImage(at: cmTime, actualTime: nil)
                DispatchQueue.main.async {
                    cellImage.image = UIImage(cgImage: image!)
                }
            }
        })
        
        /// 防止请求过多
        ACDocumentVidiosDelegate.requestCount += 1
        if ACDocumentVidiosDelegate.requestCount>=20 {
            let range = NSRange(location: 0, length: 10)
            ACDocumentVidiosDelegate.requestArray.removeObjects(in: range)
            ACDocumentVidiosDelegate.requestCount -= 10
        }
        ACDocumentVidiosDelegate.requestArray.add(requestId)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //选中时候，播放视频
        tableView.deselectRow(at: indexPath, animated: true)
        if (tapBlock != nil) {
            PHCachingImageManager.default().requestPlayerItem(forVideo: ACDocumentsDataModel.sharedDataModel.allVedios[indexPath.row], options: nil, resultHandler: {
                item, _ in
                if item==nil{
                    return
                }
                else{
                    DispatchQueue.main.async {
                        self.tapBlock!(item!)
                    }
                }
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
}
