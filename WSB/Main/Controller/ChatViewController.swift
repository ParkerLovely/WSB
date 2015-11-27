
//
//  ChatViewController.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/23.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    //聊天的好友对象
    var friend : XMPPUserCoreDataStorageObject!
    
    //添加键盘监听的 约束
    var inputViewConstraint : NSLayoutConstraint?
    
    //创建tableview
    var tableView : UITableView!
    
    //聊天信息数据对象
    var messageData : MessageData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageData = MessageData(friendJid: friend.jid, refreshData: {
            [weak mySelf = self]
            () -> Void in
            mySelf?.dataRefresh()
        })
        
        
        self.setupView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillChange:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }
    
    func dataRefresh() {
        tableView.reloadData()
    }
    
    //通过代码设置 view
    func setupView() {
        //创建tableview
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.greenColor()
        //代码实现自动布局  这里设置为 false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        let inputView = InputView.chatInputView()
        inputView.chatTextView.delegate = self
        //代码实现自动布局  这里设置为 false
        inputView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(inputView)
        
        
        
        //设置要添加约束的空间 放到字典中
        let views : [String : AnyObject] = ["tableView" : tableView, "inputView" : inputView]
        
        
        //1.tableview 水平方向约束
        let tabviewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: views)
        self.view.addConstraints(tabviewHConstraints)
        
        //2.inputview 水平方向约束
        let inputViewHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[inputView]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: views)
        //添加约束
        self.view.addConstraints(inputViewHConstraints)
        
        //垂直方向的 约束
        let vContraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[tableView]-0-[inputView(50)]-0-|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: views)
        self.view.addConstraints(vContraints)
        
        //获取底部约束
        inputViewConstraint = vContraints.last
        
    }
    
    
    func keyboardWillChange(noti : NSNotification) {
        // 获取窗口的高度
        let windowH = UIScreen.mainScreen().bounds.size.height
        // 键盘结束的Frm
        //字典是可选值 必须解包
        let kbEndFrm = noti.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        // 获取键盘结束的y值
        let kbEndY = kbEndFrm!.origin.y;
        //设置底部约束
        inputViewConstraint!.constant = windowH - kbEndY;
        self.view.layoutIfNeeded()
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageData.getMessage().count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
   
        var cell = tableView.dequeueReusableCellWithIdentifier("ChatCell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "ChatCell")
            cell?.textLabel?.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
            cell?.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        
        //获取聊天消息
        let msg = messageData.getMessage()[indexPath.row]
        if msg.outgoing.boolValue {
            //显示消息
            cell?.textLabel?.text = "Me:" + msg.body
        }else {
            NSLog("msg.bareJidStr ----  \(msg.bareJidStr)")
            NSLog("msg.bareJidStr ----  \(msg.body)")
            if let message = msg.body {
                cell?.textLabel?.text = msg.bareJidStr + " : " + message
            }
        }
        return cell!
    }

    
    func textViewDidChange(textView: UITextView) {
        
        //点击 send 是换行 修改为发送消息
        var text = textView.text as NSString
        if text.rangeOfString("\n").length != 0{
            NSLog("发送消息")
            //去除换行符
            text = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            self.sendMsgWithText(text as String)
            //清空之前的数据
            textView.text = nil
        }
    }
    
    //发送数据
    func sendMsgWithText(text : String) {
        //消息模块扩展方法  chat 表示一对一聊天
        XMPPManager.getInstance().sendMessage(text, msgType: "chat", jid: friend.jid)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
}
