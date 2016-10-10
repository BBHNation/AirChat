//
//  ACVisitingCardVC.swift
//  AirChat
//
//  Created by Hancock on 2016/10/8.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACVisitingCardVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var ACCardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ACVisitingCardCollectionViewCell
        if indexPath.row%2==0 {
            cell.cardBackImage.image = UIImage.init(imageLiteralResourceName: "testBack2")
        }
        else{
            cell.cardBackImage.image = UIImage.init(imageLiteralResourceName: "testBack")
        }
        DispatchQueue.global().async {
            cell.cardMostColor = cell.cardBackImage.image?.mostColor()
        }
        return cell
    }
    
    

}
