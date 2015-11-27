//
//  EditTableViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/21.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {

    @IBOutlet weak var editTextField: UITextField!
    
    var showContent : String!
    //反向传值
    var editDataFunc : (String ->Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("save"))
        editTextField.text = showContent
        
    }

    func save() {
        editDataFunc!(editTextField.text!)
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
}
