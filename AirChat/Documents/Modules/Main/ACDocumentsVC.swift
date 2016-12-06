//
//  ACDocumentsVC.swift
//  AirChat
//
//  Created by Hancock on 2016/11/16.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import AVFoundation

class ACDocumentsVC: UIViewController,UIScrollViewDelegate {
    enum documentType {
        case Image
        case Vidio
        case Contact
    }
    
    var docType = documentType.Image//初始化
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var vidioTableView: UITableView!
    @IBOutlet weak var contactTableView: UITableView!
    
    @IBOutlet weak var mainScrollView: UIScrollView!//装载三个View
    @IBOutlet weak var floatView: UIView!//滑动的View
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var vidioWidth: NSLayoutConstraint!
    @IBOutlet weak var contactWidth: NSLayoutConstraint!
    
    
    let imageDelegate = ACDocumentImagesDelegate()
    let vedioDelegate = ACDocumentVidiosDelegate()
    let contactDelegate = ACDocumentContactsDelegate()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageWidth.constant = UIScreen.main.bounds.size.width
        vidioWidth.constant = UIScreen.main.bounds.size.width
        contactWidth.constant = UIScreen.main.bounds.size.width
        
        
        //初始化数据
        ACDocumentsDataModel.sharedDataModel.getAllPhtotos()
        ACDocumentsDataModel.sharedDataModel.getAllVedios()
        
        
        //初始化图片collection协议
        imageCollectionView.delegate = imageDelegate
        imageCollectionView.dataSource = imageDelegate
        
        
        //初始化vedio协议
        vidioTableView.register(UINib(nibName: "ACDocumentVedioCell", bundle: nil), forCellReuseIdentifier: "VedioCell")
        vidioTableView.rowHeight = 111
        vidioTableView.delegate = vedioDelegate
        vidioTableView.dataSource = vedioDelegate
        vedioDelegate.tapBlock = { (senderItem)-> () in
            self.navigationController?.hidesBarsOnTap = true
            self.performSegue(withIdentifier: "playVedio", sender: senderItem)
        }
        
        
        //初始化contact协议
        contactTableView.register(UINib(nibName: "ACDocumentContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        contactTableView.delegate = contactDelegate
        contactTableView.dataSource = contactDelegate
        
        //这里初始化
        self.mainScrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    
    /// 点击图片按钮
    ///
    /// - Parameter sender: 按钮
    @IBAction func iamgeButtonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
           self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        })
    }
    
    
    /// 点击视频按钮
    ///
    /// - Parameter sender: 按钮
    @IBAction func vidioButtonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            self.mainScrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.size.width, y: 0)
        })
    }

    
    /// 点击联系人按钮
    ///
    /// - Parameter sender: 按钮
    @IBAction func contactButtonClick(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            self.mainScrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.size.width*2, y: 0)
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x/UIScreen.main.bounds.size.width
        var rect = self.floatView.frame
        rect.origin.x = UIScreen.main.bounds.size.width/6-rect.size.width/2+UIScreen.main.bounds.size.width*x/3
        self.floatView.frame = rect
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playVedio" {
            let vedioPlayerVC = segue.destination as? ACDocumentVidioPlayerVC
            vedioPlayerVC?.avplayerItem = sender as? AVPlayerItem
            
        }
    }
}
