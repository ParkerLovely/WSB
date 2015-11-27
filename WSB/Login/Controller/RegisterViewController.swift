//
//  RegisterViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/19.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

protocol PassValueDelegate {
    func passRegisterName(register : String)
}





class RegisterViewController: UIViewController, XMPPRegisterDelegate {

    var passValueDelegate : PassValueDelegate?
    
    var didFinishRegister : (String ->Void)?
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    @IBAction func tapEvent(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var bgImageView: UIImageView!
  
    @IBAction func editingChanged(sender: UITextField) {
        registerButton.enabled = !self.userNameTextField.text!.isEmpty && !self.passwordTextField.text!.isEmpty
    }
    
    
    
    
    
    
    
    
    @IBAction func registerButtonTapped(sender: UIButton) {
        
        UserInfo.getInstance().registerUserName = userNameTextField.text
        UserInfo.getInstance().registerPassword = passwordTextField.text
        //用户注册
        self.userRegister()
        
        
    }
    
    
    func userRegister() {
        self.view.endEditing(true)
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            MBProgressHUD.showError("所有字段不能为空", toView: self.view, color: loginProgressHUDColor)
            return
        }
        MBProgressHUD.showMessage("正在注册中", toView: self.view, color: loginProgressHUDColor)
        XMPPManager.getInstance().userRegister(self)
        
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.roundRect()
        registerButton.setStretchedBG(loginButtonImageName)
        let bgImage = UIImage(named: "33")?.drn_boxblurImageWithBlur(0.3)
        bgImageView.image = bgImage
    }

    func showError(errorText : String) {
        MBProgressHUD.hideHUDForView(self.view)
        MBProgressHUD.showError(errorText, toView: nil, color: loginProgressHUDColor)
        
    }

    func registerError() {
        self.showError("网络异常")
    }
    
    
    func registerSuccess() {
        MBProgressHUD.hideHUDForView(self.view)
        MBProgressHUD.showSuccess("注册成功", toView: nil, color: loginProgressHUDColor)
        
        didFinishRegister?(userNameTextField.text!)
        self.dismissViewControllerAnimated(true, completion: nil)
        

       
    }
    
        
    func registerFail() {
        self.showError("用户名或密码异常")
    }
    
}
