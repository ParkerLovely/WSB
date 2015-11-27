//
//  PrefileTableViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/21.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

class PrefileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
 
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var teleLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    
    //将个人信息更新
    func undateUserInfoView() {
        let vCardUserInfo = XMPPManager.getInstance().vCardUserInfo
        //设置
        
        if vCardUserInfo.photo != nil {
            self.headerImageView.image = UIImage(data: vCardUserInfo.photo)
        }
        
        nickNameLabel.text = vCardUserInfo.nickname
        userNameLabel.text = UserInfo.getInstance().userName
        companyLabel.text = vCardUserInfo.orgName
        if let orgunits = vCardUserInfo.orgUnits {
            groupLabel.text = orgunits[0] as? String
        }else {
            groupLabel.text = ""
        }
        titleLabel.text = vCardUserInfo.title
        //电话邮件xml,此处不解析了
        teleLabel.text = vCardUserInfo.note
        emailLabel.text = vCardUserInfo.mailer
    
    }
    //将界面中信息保存到数据库中
    func savevCardInfo() {
        let vCardUserInfo = XMPPManager.getInstance().vCardUserInfo
        vCardUserInfo.nickname = nickNameLabel.text
        vCardUserInfo.orgName = companyLabel.text
        let array : [AnyObject] = [groupLabel.text!]
        vCardUserInfo.orgUnits = array
        vCardUserInfo.title = titleLabel.text
        vCardUserInfo.note = teleLabel.text
        vCardUserInfo.mailer = emailLabel.text
        
        
        vCardUserInfo.photo = UIImagePNGRepresentation(headerImageView.image!)
        
        //save
        XMPPManager.getInstance().updatevCardInfoToDataBase(vCardUserInfo)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImageView.round()
        self.undateUserInfoView()
        
       
    }

    //编辑头像
    func editHeader() {
        let alertController = UIAlertController(title: "请选择获取头像方式", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let defaultAction1 = UIAlertAction(title: "照相", style: UIAlertActionStyle.Default, handler: chooseHeadImageFromCamera)
        let defaultAction2 = UIAlertAction(title: "相册", style: UIAlertActionStyle.Default, handler: chooseHeadImageFromLibrary)
        let defaultAction3 = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(defaultAction1)
        alertController.addAction(defaultAction2)
        alertController.addAction(defaultAction3)
        self.presentViewController(alertController, animated: true, completion: nil)

    }

    func chooseHeadImageFromCamera(alertAction : UIAlertAction) {
        self.chooseHeaderImageStyle(UIImagePickerControllerSourceType.Camera)
    }
    func chooseHeadImageFromLibrary(alertAction : UIAlertAction) {
        self.chooseHeaderImageStyle(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func chooseHeaderImageStyle(type : UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = type
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
        
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        headerImageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.savevCardInfo()
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.tag == 0 {
            //跳转
            self.performSegueWithIdentifier("editUserInfo", sender: cell)
        }else if cell?.tag == 1 {
            self.editHeader()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let desVC = segue.destinationViewController
        if desVC.isKindOfClass(EditTableViewController.classForCoder()) {
            let editVC = desVC as? EditTableViewController
            let cell = sender as? UITableViewCell
            
            editVC?.title = cell?.textLabel?.text
            editVC?.showContent = cell?.detailTextLabel?.text
            editVC!.editDataFunc = {
                (edutContent : String?) in
                cell?.detailTextLabel?.text = edutContent
                self.savevCardInfo()
            }
        }
    }
}


























