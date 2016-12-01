//
//  ACDocumentContactsDelegate.swift
//  AirChat
//
//  Created by Hancock on 2016/12/1.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACDocumentContactsDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        return cell
    }
}
