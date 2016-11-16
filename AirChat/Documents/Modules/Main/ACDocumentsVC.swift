//
//  ACDocumentsVC.swift
//  AirChat
//
//  Created by Hancock on 2016/11/16.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACDocumentsVC: UIViewController {
    enum documentType {
        case Image
        case Vidio
        case Contact
    }
    
    var docType = documentType.Image//初始化
    @IBOutlet weak var imageTableView: UITableView!
    @IBOutlet weak var vidioTableView: UITableView!
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var mainScrollView: UIScrollView!//装载三个tableView
    @IBOutlet weak var floatView: UIView!//滑动的View
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var vidioWidth: NSLayoutConstraint!
    @IBOutlet weak var contactWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageWidth.constant = UIScreen.main.bounds.size.width
        vidioWidth.constant = UIScreen.main.bounds.size.width
        contactWidth.constant = UIScreen.main.bounds.size.width
        iamgeButtonClick(Any.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    
    /// 点击图片按钮
    ///
    /// - Parameter sender: 按钮
    @IBAction func iamgeButtonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            var rect = self.floatView.frame
            rect.origin.x = UIScreen.main.bounds.size.width/6-rect.size.width/2
            self.floatView.frame = rect
            self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        })
    }
    
    
    /// 点击视频按钮
    ///
    /// - Parameter sender: 按钮
    @IBAction func vidioButtonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            var rect = self.floatView.frame
            rect.origin.x = UIScreen.main.bounds.size.width/2-rect.size.width/2
            self.floatView.frame = rect
            self.mainScrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.size.width, y: 0)
        })
    }

    
    /// 点击联系人按钮
    ///
    /// - Parameter sender: 按钮
    @IBAction func contactButtonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            var rect = self.floatView.frame
            rect.origin.x = UIScreen.main.bounds.size.width*5/6-rect.size.width/2
            self.floatView.frame = rect
            self.mainScrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.size.width*2, y: 0)
        })
    }
}
