//
//  ACDocumentsVC.swift
//  AirChat
//
//  Created by Hancock on 2016/11/16.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import AVFoundation
import MJRefresh
import KVOController



/// 一些KVO所需的context
private var ACDocumentsVCContextContacts = 0
private var ACDocumentsVCContextVedios = 1
private var ACDocumentsVCContextPhotos = 2

class ACDocumentsVC: UIViewController,UIScrollViewDelegate {
    
    /// 记录当前的界面在哪里
    ///
    /// - Image: 图片界面
    /// - Vidio: 视频界面
    /// - Contact: 联系人界面
    enum documentType {
        case Image
        case Vidio
        case Contact
    }
    
    var docType = documentType.Image//初始化
    
    @IBOutlet weak var imageCollectionView: UICollectionView!//图片collectionview
    @IBOutlet weak var vidioTableView: UITableView!//视频tableView
    @IBOutlet weak var contactTableView: UITableView!//联系人tableView
    
    @IBOutlet weak var mainScrollView: UIScrollView!//装载三个View
    @IBOutlet weak var floatView: UIView!//滑动的View
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!//图片collectionview的宽度约束
    @IBOutlet weak var vidioWidth: NSLayoutConstraint!//视频tableView宽度约束
    @IBOutlet weak var contactWidth: NSLayoutConstraint!//联系人tableView宽度约束
    
    
    let imageDelegate = ACDocumentImagesDelegate()//图片collectionview
    let vedioDelegate = ACDocumentVidiosDelegate()//图片collectionview
    let contactDelegate = ACDocumentContactsDelegate()//图片collectionview
    
    
    /// 当界面将要出现的时候
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnTap = false
    }
    
    
    /// 界面加载后
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 修改了三个约束，每个约束等于屏幕宽度
        imageWidth.constant = UIScreen.main.bounds.size.width
        vidioWidth.constant = UIScreen.main.bounds.size.width
        contactWidth.constant = UIScreen.main.bounds.size.width
        
        
        /// 这里有一个bug，getAllVedios不能多线程调用，可能与iOS API有关
        ACDocumentsDataModel.sharedDataModel.getAllVedios()
        
        /// 初始化图片collection协议
        imageCollectionView.delegate = imageDelegate
        imageCollectionView.dataSource = imageDelegate
        
        /// 添加下拉刷新
        imageCollectionView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            ACDocumentsDataModel.sharedDataModel.getAllPhtotos()
        })
        imageCollectionView.mj_header.beginRefreshing()
        
        
        //初始化vedio协议
        vidioTableView.register(UINib(nibName: "ACDocumentVedioCell", bundle: nil), forCellReuseIdentifier: "VedioCell")
        vidioTableView.rowHeight = 111
        vidioTableView.delegate = vedioDelegate
        vidioTableView.dataSource = vedioDelegate
        /// 添加下拉刷新
        vedioDelegate.tapBlock = { (senderItem)-> () in
            self.navigationController?.hidesBarsOnTap = true
            self.performSegue(withIdentifier: "playVedio", sender: senderItem)
        }
        
        
        
        //初始化contact协议
        contactTableView.register(UINib(nibName: "ACDocumentContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        contactTableView.delegate = contactDelegate
        contactTableView.dataSource = contactDelegate
        contactTableView.rowHeight = 70
        /// 添加下拉刷新
        contactTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            ACDocumentsDataModel.sharedDataModel.getAllContact()
        })
        contactTableView.mj_header.beginRefreshing()
        
        
        //设置监听属性
        ACDocumentsDataModel.sharedDataModel.addObserver(self, forKeyPath: "contactsArray", options: .new, context: &ACDocumentsVCContextContacts)
        ACDocumentsDataModel.sharedDataModel.addObserver(self, forKeyPath: "allPhotos", options: .new, context: &ACDocumentsVCContextPhotos)
        ACDocumentsDataModel.sharedDataModel.addObserver(self, forKeyPath: "allVedios", options: .new, context: &ACDocumentsVCContextVedios)
        
        
        //这里初始化
        self.mainScrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
    }
    
    /// 取消监听属性
    deinit {
        ACDocumentsDataModel.sharedDataModel.removeObserver(self, forKeyPath: "contactsArray", context: &ACDocumentsVCContextContacts)
        ACDocumentsDataModel.sharedDataModel.removeObserver(self, forKeyPath: "allPhotos", context: &ACDocumentsVCContextPhotos)
        ACDocumentsDataModel.sharedDataModel.removeObserver(self, forKeyPath: "allVedios", context: &ACDocumentsVCContextVedios)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /// 监听到有属性修改的消息
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        /// 联系人数组有修改
        if context == &ACDocumentsVCContextContacts{
            if (change?[.newKey]) != nil{
                contactTableView.reloadData()
                contactTableView.mj_header.endRefreshing()
            }
        }
        /// 视频数组有修改，这里目前没用到
        else if context == &ACDocumentsVCContextVedios {
                if (change?[.newKey]) != nil{
                    vidioTableView.reloadData()
                    vidioTableView.mj_header.endRefreshing()
                }
        }
        /// 图片数组有修改
        else if context == &ACDocumentsVCContextPhotos{
                if (change?[.newKey]) != nil{
                imageCollectionView.reloadData()
                imageCollectionView.mj_header.endRefreshing()
            }
        }
        else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
        
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
    
    
    /// MainScrollView滑动时候的一些操作
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x/UIScreen.main.bounds.size.width
        var rect = self.floatView.frame
        rect.origin.x = UIScreen.main.bounds.size.width/6-rect.size.width/2+UIScreen.main.bounds.size.width*x/3
        self.floatView.frame = rect
    }
    
    
    
    @IBAction func popLeftPersonalCenter(_ sender: Any) {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController as! ACResideRootVC
        rootVC.presentLeftMenuViewController()
    }
    
    /// 跳转到其他界面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playVedio" {
            
            /// 跳转到播放视频界面
            let vedioPlayerVC = segue.destination as? ACDocumentVidioPlayerVC
            vedioPlayerVC?.avplayerItem = sender as? AVPlayerItem
        }
    }
}
