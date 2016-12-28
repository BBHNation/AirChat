//
//  ACMyCardTVC.swift
//  AirChat
//
//  Created by Hancock on 2016/12/28.
//  Copyright © 2016年 Binhan Bai. All rights reserved.
//

import UIKit
import SVProgressHUD

class ACMyCardTVC: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var phoneTextFeild: UITextField!
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var backImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dicData = UserDefaults.standard.object(forKey: "myCard") as? Data
        let count = dicData?.count
        if (count==nil) {
        }
        else {
            let dic = NSKeyedUnarchiver.unarchiveObject(with: dicData!) as! NSDictionary
            nameTextFeild.text = (dic["content"] as! [String:Any])["name"] as? String
            phoneTextFeild.text = (dic["content"] as! [String:Any])["phone"] as? String
            backImageView.image = (dic["content"] as! [String:Any])["backImage"] as? UIImage
        }
        
        
        
        backImageView.layer.cornerRadius=10;
        backImageView.layer.shadowColor=UIColor.black.cgColor
        backImageView.layer.shadowOffset=CGSize(width: 10, height: 10)
        backImageView.layer.shadowOpacity=0.5
        backImageView.layer.shadowRadius=5;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancleAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func changeBackImage(_ sender: Any) {
        let alterController = UIAlertController(title: "选择图片", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let takePhotoAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default) { (action) in
            self.takePhoto()
        }
        
        let localPhotoAction = UIAlertAction(title: "相册", style: UIAlertActionStyle.default) { (action) in
            self.localPhoto()
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
        }
        
        alterController.addAction(takePhotoAction)
        alterController.addAction(localPhotoAction)
        alterController.addAction(cancelAction)
        self.present(alterController, animated: true, completion: nil)
    }
    
    
    func takePhoto() {
        let sourceType = UIImagePickerControllerSourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.delegate = self
            //设置拍照后可以编辑
            picker.allowsEditing = true
            picker.sourceType = sourceType
            self.present(picker, animated: true, completion: nil)
        }
        else {
            print("相机无法使用")
        }
    }
    
    func localPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        //设置拍照后可以编辑
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let type = info[UIImagePickerControllerMediaType] as! String
        
        //当选择的类型是图片
        if (type == "public.image")
        {
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            
            //关闭相册界面
            picker.dismiss(animated: true, completion: nil)
            //创建一个选择后图片的小图标放在下方
            //类似微薄选择图后的效果
            //加在视图中
            backImageView.image = image
            backImageView.layer.shadowRadius=5;
        }
    }

    @IBAction func shareAction(_ sender: Any) {
        if (nameTextFeild.text?.isEmpty)! || (phoneTextFeild.text?.isEmpty)! || (backImageView.image==nil) {
            SVProgressHUD.showError(withStatus: "内容不能为空")
        }
        else {
            let dic = ["name":nameTextFeild.text!,"phone":phoneTextFeild.text!,"backImage":backImageView.image!] as [String : Any]
            let finalDic = ["type":"card","content":dic] as [String : Any]
            let data = NSKeyedArchiver.archivedData(withRootObject: finalDic)
            ACConnectyModel.sharedModel.sendDataWith(data: data)
            SVProgressHUD.showSuccess(withStatus: "传输成功")
        }
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let dic = ["name":nameTextFeild.text!,"phone":phoneTextFeild.text!,"backImage":backImageView.image!] as [String : Any]
        let finalDic = ["type":"card","content":dic] as [String : Any]
        let data = NSKeyedArchiver.archivedData(withRootObject: finalDic)
        UserDefaults.standard.set(data, forKey: "myCard")
        SVProgressHUD.showSuccess(withStatus: "保存成功")
        self.dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}
