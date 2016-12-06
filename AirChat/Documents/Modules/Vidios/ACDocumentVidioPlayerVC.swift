//
//  ACDocumentVidioPlayerVC.swift
//  AirChat
//
//  Created by Hancock on 2016/12/6.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ACDocumentVidioPlayerVC: UIViewController {
    let avplayer = AVPlayer()
    let avplayerLayer = AVPlayerLayer()
    var avplayerItem : AVPlayerItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        avplayer.replaceCurrentItem(with: avplayerItem)
        avplayer.play()
        avplayerLayer.player = avplayer
        avplayerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.view.layer.addSublayer(avplayerLayer)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
