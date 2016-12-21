//
//  ACPersonalCenterTVC.swift
//  AirChat
//
//  Created by Hancock on 2016/10/10.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACPersonalCenterTVC: UITableViewController{

    @IBOutlet weak var headImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headImageView.layer.shadowColor = UIColor.black.cgColor
        headImageView.layer.shadowOpacity = 1
        headImageView.layer.shadowOffset = CGSize.init(width: 3, height: 3)
        headImageView.layer.cornerRadius = 35;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            ACConnectyModel.sharedModel.startConnect(viewController: self)
        }
        else if indexPath.row == 2 {
            let data = NSData()
            ACConnectyModel.sharedModel.sendDataWith(data: data)
        }
    }
    

}
