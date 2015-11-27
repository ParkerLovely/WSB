//
//  OherLoginViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/19.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

class OherLoginViewController: LoginBaseViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!
    
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBAction func tapEvent(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        if userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            //self.showAletView()
            self.showError("所有字段不能为空")
            return
        }
        userLogin(userNameTextField.text!, password: passwordTextField.text!)
    }
    
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.roundRect()
        loginButton.setStretchedBG(loginButtonImageName)
        let bgImage = UIImage(named: "aaa")?.drn_boxblurImageWithBlur(0.3)
        bgImageView.image = bgImage
    }

   
    
    
}
