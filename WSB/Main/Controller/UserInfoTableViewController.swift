//
//  UserInfoTableViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/20.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

class UserInfoTableViewController: UITableViewController {

    
    
    
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        headerImageView.roundRect()
        userNameLabel.text = UserInfo.getInstance().userName
        let userInfo_vCard = XMPPManager.getInstance().vCardUserInfo
        nickNameLabel.text = userInfo_vCard.nickname
        
        if userInfo_vCard.photo != nil {
            self.headerImageView.image = UIImage(data: userInfo_vCard.photo)
        }
    }

    @IBAction func logoutButtonTapped(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        self.view.window?.rootViewController = storyboard.instantiateInitialViewController()
        UserInfo.getInstance().loginState = LoginState.Offline
        UserInfo.getInstance().saveInfo()

        
        
        
    }
   
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
