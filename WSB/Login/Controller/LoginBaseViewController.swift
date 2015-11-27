
//
//  LoginBaseViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/20.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

class LoginBaseViewController: UIViewController, XMPPLoginDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func userLogin(userName : String, password : String) {
        view.endEditing(true)
        UserInfo.getInstance().userName = userName
        UserInfo.getInstance().password = password
        MBProgressHUD.showMessage("正在登录中", toView: self.view, color: loginProgressHUDColor)
        XMPPManager.getInstance().userLogIn(self)
    }
    
    func showError(errorText : String) {
        MBProgressHUD.hideHUDForView(self.view)
        MBProgressHUD.showError(errorText, toView: nil, color: loginProgressHUDColor)
        
    }
    
    func loginSuccess() {
        UserInfo.getInstance().loginState = LoginState.Online
        UserInfo.getInstance().saveInfo()
        
        MBProgressHUD.hideHUDForView(self.view)
        MBProgressHUD.showSuccess("登录成功", toView: nil, color: loginProgressHUDColor)
        self.dismissViewControllerAnimated(true, completion: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.view.window?.rootViewController = mainStoryboard.instantiateInitialViewController()
        
    }
    
    func loginFail() {
        self.showError("用户名或密码异常")
    }
    
    func loginNetError() {
        self.showError("网络异常")
    }
    
}
