//
//  ACVisitingCardVC.swift
//  AirChat
//
//  Created by Hancock on 2016/10/8.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

/// 这里是主界面，名片界面
class ACVisitingCardVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    /// 主界面所需要的数据模型
    var dataModel:ACVisitingCardDataModel!
    
    /// 使用CollectionView来布局名片
    @IBOutlet weak var ACCardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel = ACVisitingCardDataModel()
        if true {
            //没有登录时候走这里
            self.performSegue(withIdentifier: "login", sender: self)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 弹出左侧个人中心
    @IBAction func presentLeftMune(_ sender: AnyObject) {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController as! ACResideRootVC
        rootVC.presentLeftMenuViewController()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
   
    
    /// collectionView data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.cardCellArray.count
    }
    
    /// collectionView data source
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ACVisitingCardCollectionViewCell
        cell.cellModel = dataModel.cardCellArray.object(at: indexPath.row) as! ACVisitingCardCellModel
        return cell
    }
    
    /// collectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at index \(indexPath.row)")
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier=="login") {
           
        }
        return true
    }
    

}
