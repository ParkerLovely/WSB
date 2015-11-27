//
//  ContactTableViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/21.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit



class ContactTableViewController: UITableViewController, DataRefreshDelegate {

    
    var contactData : ContactData!
    
    
    //协议中的方法 刷新数据
    func dataRefresh() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //从数据库获取数据
        contactData = ContactData(refreshData: {
            [weak mySelf = self]
            () -> Void in
            mySelf!.tableView.reloadData()
        })
    
    }

    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return contactData.getContacts().count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let contact = contactData.getContacts()[indexPath.row]
        cell.textLabel?.text = contact.displayName
        switch contact.sectionNum.intValue {
        case 0:
            cell.detailTextLabel?.text = "在线"
        case 1:
            cell.detailTextLabel?.text = "离开"
        case 2:
            cell.detailTextLabel?.text = "离线"
        default:
            break
        }
        
        return cell
    }
 

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let friend : XMPPUserCoreDataStorageObject = contactData.getContacts()[indexPath.row]
            XMPPManager.getInstance().removeFriend(friend.jid)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let friend : XMPPUserCoreDataStorageObject = contactData.getContacts()[indexPath.row]
        self.performSegueWithIdentifier("chatSeque", sender: friend)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC : AnyObject = segue.destinationViewController
        if destVC.isKindOfClass(ChatViewController.classForCoder()) {
            let chatVC = destVC as? ChatViewController
            chatVC!.friend = sender as? XMPPUserCoreDataStorageObject
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
