//
//  ACVisitingCardVC.swift
//  AirChat
//
//  Created by Hancock on 2016/10/8.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACVisitingCardVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    var dataModel:ACVisitingCardDataModel!
    @IBOutlet weak var ACCardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel = ACVisitingCardDataModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //弹出左侧个人中心
    @IBAction func presentLeftMune(_ sender: AnyObject) {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController as! ACResideRootVC
        rootVC.presentLeftMenuViewController()
    }
    
    
    
    
    //collectionView data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.cardCellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ACVisitingCardCollectionViewCell
        
        cell.cellModel = dataModel.cardCellArray.object(at: indexPath.row) as! ACVisitingCardCellModel
        return cell
    }
    
    
    //collectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at index \(indexPath.row)")
    }
    
    

}
