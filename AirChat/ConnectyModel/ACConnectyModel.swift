//
//  ACConnectyModel.swift
//  AirChat
//
//  Created by Hancock on 2016/12/21.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

/// 这里是蓝牙Wi-Fi连接模块

import UIKit
import Photos
import MultipeerConnectivity//连接的主要框架
import SVProgressHUD

class ACConnectyModel: NSObject, MCBrowserViewControllerDelegate, MCSessionDelegate {
    static let sharedModel = ACConnectyModel()//单例模式
    var browserVC : MCBrowserViewController?//选择连接的界面
    var advertiser : MCAdvertiserAssistant?//广播
    var connectSession : MCSession?//连接的Session
    var connectPeerID : MCPeerID?//本机的连接ID
    
    /// 初始化
    override init() {
        //Setup peer ID
        connectPeerID = MCPeerID(displayName: UIDevice.current.name)
        
        //Setup session
        connectSession = MCSession(peer: connectPeerID!)
        
        //Setup BrowserViewController
        browserVC = MCBrowserViewController(serviceType: "airChat", session: connectSession!)
        
        //Setup Advertiser
        advertiser = MCAdvertiserAssistant(serviceType: "airChat", discoveryInfo: nil, session: connectSession!)
        
    }
    
    /// 设置协议
    func setDelegate() {
        connectSession?.delegate = self
        browserVC?.delegate = self;
    }
    
    /// 开始广播
    func startAdvertise() {
        //Start advertise
        advertiser?.start()
    }
    
    
    /// 发送一组Data
    func sendDataWith(data:NSData) {
        let string = "hello world";
        let stringData = string.data(using: String.Encoding.utf8)
        do {
            try?
            connectSession?.send(stringData!, toPeers: (connectSession?.connectedPeers)!, with: MCSessionSendDataMode.reliable)
        }
    }
    
    
    /// 根据本地URL发送文件
    func sendFileWith(url:URL) -> Progress {
        let progress = connectSession?.sendResource(at: url, withName: "vedio", toPeer: (connectSession?.connectedPeers.first)!, withCompletionHandler: { (error) in
            print("传输完毕")
            //这里发通知
        })
        return progress!
    }
    
    /// 弹出连接界面
    func startConnect(viewController:UIViewController) {
        viewController.present(browserVC!, animated: true, completion: nil)
    }
    
    
    /// MCBrowserViewControllerDelegate
    /// Notifies delegate that finish connect.
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        print("已经连接上")
        browserVC?.dismiss(animated: true, completion: { 
            print("连接上谈回")
        })
    }
    
    /// MCBrowserViewControllerDelegate
    /// Notifies delegate that the user taps the cancel button.
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        print("取消连接")
        browserVC?.dismiss(animated: true, completion: nil)
    }
    
    /// MCBrowserViewControllerDelegate
    // Notifies delegate that a peer was found; discoveryInfo can be used to
    // determine whether the peer should be presented to the user, and the
    // delegate should return a YES if the peer should be presented; this method
    // is optional, if not implemented every nearby peer will be presented to
    // the user.
    func browserViewController(_ browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool {
        return true
    }
    
    
    /// MCSessionDelegate
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "thePeersChange"), object: nil)
        print("change state : \(state) ")
    }
    
    /// MCSessionDelegate
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let newString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        print("data string is : \(newString)")
    }
    
    /// MCSessionDelegate
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("did receive")
    }
    
    /// MCSessionDelegate
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("start receiving")
    }
    
    /// MCSessionDelegate
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        let data = NSData(contentsOf: localURL)
        let string = localURL.absoluteString + ".mov"
        let url = URL(string: string)
        data?.write(to: url!, atomically: true)
        
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url!)
        }) { (success, error) in
            if success {
                print("接受到成功")
                SVProgressHUD.showSuccess(withStatus: "传输成功")
            }
            else {
                print("接受失败，错误是\(error)")
            }
        }
    }

}
