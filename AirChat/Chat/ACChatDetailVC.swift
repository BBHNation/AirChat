//
//  ACChatDetailVC.swift
//  AirChat
//
//  Created by Hancock on 2016/12/8.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit

class ACChatDetailVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var inputBackView: UIView!
    @IBOutlet weak var inputBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatMainTableView: UITableView!
    @IBOutlet weak var inputTextFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardNotification()
    }
    
    /// 添加键盘启动时候的一些操作
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)) , name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)) , name: NSNotification.Name.UIKeyboardWillHide , object: nil)
        chatMainTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        chatMainTableView.register(UINib(nibName: "ACChatCell", bundle: nil), forCellReuseIdentifier: "chatCell")
        chatMainTableView.rowHeight = 65
    }
    @IBAction func hideKeyBoard(_ sender: Any) {
        inputTextFeild.resignFirstResponder()
    }
    
    
    /// 键盘即将弹出时候
    ///
    /// - Parameter sender: 通知
    func keyboardWillShow(sender:NSNotification) {
        let frameNew = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let insetNewBottom = chatMainTableView.convert(frameNew, from: nil).height
        let duration = (sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        UIView.animate(withDuration: duration, animations: {
            self.inputBackView.transform = CGAffineTransform(translationX: 0, y: -insetNewBottom)
            self.chatMainTableView.transform = CGAffineTransform(translationX: 0, y: -insetNewBottom)
        }, completion: {
            compelet in
        })
        
    }
    
    func keyboardWillHide(sender:NSNotification) {
        let duration = (sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        UIView.animate(withDuration: duration, animations: {
            self.inputBackView.transform = CGAffineTransform.identity
            self.chatMainTableView.transform = CGAffineTransform.identity
        }, completion: {
            compelet in
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("开始编辑")
        return true
    }
    
    
    /// UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        
        return cell
    }


}
