//
//  LoginViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/19.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

class LoginViewController: LoginBaseViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var loginButton: UIButton!
  
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerImageView.round()
        backgroundView.roundRect()
        loginButton.setStretchedBG(loginButtonImageName)
        let bgImage = UIImage(named: "222")?.drn_boxblurImageWithBlur(0.6)
        backgroundImageView.image = bgImage
        userLabel.text = UserInfo.getInstance().userName ?? "用户名"
        
    }
    
    @IBAction func endEditing(sender: AnyObject) {
        view.endEditing(true)
    }
    
 
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        if userLabel.text == "用户名" || passwordTextfield.text!.isEmpty {
            //self.showError("所有字段不能为空")
            let alertView = DXAlertView(title: "警告", contentText: "所有字段不能为空", leftButtonTitle: "取消", rightButtonTitle: "确定")
            alertView.show()
            return
        }
        userLogin(userLabel.text!, password: passwordTextfield.text!)
        
    }
    
//    func passRegisterName(register: String) {
//        self.userLabel.text = register
//        
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "xxoo" {
            let registerVC = segue.destinationViewController as! RegisterViewController
            
            registerVC.didFinishRegister = {
                [unowned mySelf = self]
                (text) ->Void in
                mySelf.userLabel.text = text
                
                MBProgressHUD.showSuccess("注册成功请输入密码进行登录", toView: self.view, color: loginProgressHUDColor)
                
            }
            
            //registerVC.passValueDelegate = self
        }
    }
   
    
    
}



