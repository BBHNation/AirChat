//
//  ACDocumentContactsDelegate.swift
//  AirChat
//
//  Created by Hancock on 2016/12/1.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import Contacts

class ACDocumentContactsDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ACDocumentsDataModel.sharedDataModel.contactsArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let nameLabel = cell.viewWithTag(1024) as? UILabel
        let phoneLabel = cell.viewWithTag(1025) as? UILabel
        let contact = ACDocumentsDataModel.sharedDataModel.contactsArray[indexPath.row] as? CNContact
        nameLabel?.text = (contact?.givenName)! + (contact?.familyName)!
        phoneLabel?.text = contact?.phoneNumbers.first?.value.stringValue
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
