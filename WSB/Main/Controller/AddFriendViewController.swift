//
//  AddFriendViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/23.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addFriendTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        addFriendTextField.delegate = self
    }
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let friend = textField.text!
        
        if friend == UserInfo.getInstance().userName {
            self.showAlert("不能添加自己为好友")
            return true
        }
        let jid = XMPPJID.jidWithString(friend + "@tarena.com")
        
        if XMPPManager.getInstance().userExistsWithJid(jid) {
            self.showAlert("当前好友已经存在")
            return true
        }
        XMPPManager.getInstance().addFriend(jid)
        navigationController?.popViewControllerAnimated(true)
        return true        
    }
    
    
    
    
    func showAlert(msg : String) {
        
        //原来的 UIAlertView
        let alertController = UIAlertController(title: "请选择", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        //取消的 选项
        let cancelAction = UIAlertAction(title: "知道了", style: UIAlertActionStyle.Cancel, handler: { (alertAction) -> Void in
        })
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

    
    
    
    
    

   
}
