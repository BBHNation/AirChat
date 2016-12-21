//
//  ACChatListTVC.swift
//  AirChat
//
//  Created by Hancock on 2016/12/8.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import MJRefresh

class ACChatListTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(sender:)), name: NSNotification.Name(rawValue: "thePeersChange"), object: nil)
    }
    
    func receiveNotification(sender:NSNotification) {
        self.tableView.mj_header.beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ACConnectyModel.sharedModel.connectSession?.connectedPeers.count)! + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
        
        if indexPath.row==0 {
            let nameLabel = cell.viewWithTag(1024) as! UILabel
            nameLabel.text = "群聊"
            
            let imageView = cell.viewWithTag(1023) as! UIImageView
            imageView.image = UIImage(named: "chatHead-more")
        }
        else {
            let nameLabel = cell.viewWithTag(1024) as! UILabel
            nameLabel.text = ACConnectyModel.sharedModel.connectSession?.connectedPeers[indexPath.row-1].displayName
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hidesBottomBarWhenPushed = true
        self.performSegue(withIdentifier: "Detail", sender: self)
        self.hidesBottomBarWhenPushed = false
    }

    @IBAction func popLeftPersonalCenter(_ sender: Any) {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController as! ACResideRootVC
        rootVC.presentLeftMenuViewController()
    }

}
