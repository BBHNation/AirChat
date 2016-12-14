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
            self.tableView.mj_header.endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath)
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
