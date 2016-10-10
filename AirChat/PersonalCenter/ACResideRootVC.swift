//
//  ACResideRootVC.swift
//  AirChat
//
//  Created by Hancock on 2016/10/10.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import RESideMenu

class ACResideRootVC: RESideMenu {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func awakeFromNib(){
        self.backgroundImage = UIImage.init(named: "testBack")
//        self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
//        self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent
        self.contentViewShadowColor = UIColor.init(white: 1.0, alpha: 1.0)
        self.contentViewScaleValue = 0.9;
        self.scaleMenuView = false;
        self.scaleContentView = true;
        self.contentViewShadowEnabled = true;
        self.contentViewShadowColor = UIColor.init(white: 0.0, alpha: 0.8)
        self.contentViewShadowOffset = CGSize.init(width: -20, height: 0)
        self.animationDuration = 0.3;
        self.bouncesHorizontally = false;
        self.contentViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController")
        self.leftMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "ACPersonalCenter")
        ACResideRootVC.sharedResideRootVC = self
//        self.acResideRootVC = self
    }
}
