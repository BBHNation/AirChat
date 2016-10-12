//
//  ACVisitingCardVC.swift
//  AirChat
//
//  Created by Hancock on 2016/10/8.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACVisitingCardVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

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
    
    @IBAction func presentLeftMune(_ sender: AnyObject) {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController as! ACResideRootVC
        rootVC.presentLeftMenuViewController()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.cardCellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ACVisitingCardCollectionViewCell
        cell.cardBackImage.image = (dataModel.cardCellArray.object(at: indexPath.row) as! ACVisitingCardCellModel).backImage
        cell.cardMostColor = (dataModel.cardCellArray.object(at: indexPath.row) as! ACVisitingCardCellModel).backImageMostColor
        /*
        if indexPath.row%2==0 {
            cell.cardMostColor = UIColor.blue
        }
        else{
            cell.cardMostColor = UIColor.gray
        }
 */
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item at index \(indexPath.row)")
    }
    
    

}
