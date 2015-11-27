//
//  XMPPManager.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/19.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

enum OperationType {
    case LOGIN, REGISTER
}


let onLineKeyWord = "available"
let offLineKeyWord = "unavailable"

class XMPPManager: NSObject, XMPPStreamDelegate {
    
    class func getInstance() ->XMPPManager {
        struct Singleton {
            static var predicate : dispatch_once_t = 0
            static var xmppManager : XMPPManager!
        }
        dispatch_once(&Singleton.predicate) { () -> Void in
            Singleton.xmppManager = XMPPManager()
        }
        return Singleton.xmppManager
    }

    var xmppStream :XMPPStream!
    
    
    /*******************vCard模块**********************/
    
    
    var xmppvCard : XMPPvCardTempModule!
    var xmppvCardStorage : XMPPvCardCoreDataStorage!
    var avater : XMPPvCardAvatarModule!
    

    /**************************************************/
    
    
     /*******************花名册模块**********************/
    
    var roster : XMPPRoster!
    var rosterStorage : XMPPRosterCoreDataStorage!
    
    
    /**************************************************/
    
     /*******************聊天模块**********************/
    
    var msgArchiving : XMPPMessageArchiving!
    var msgStorage : XMPPMessageArchivingCoreDataStorage!
    
    
    /**************************************************/


    var loginDelegate : XMPPLoginDelegate?
    var registerDelegate : XMPPRegisterDelegate?
    var operationType : OperationType?
    
    //MARK:设置 XMPPStream
    private func setUpXMPPStream() {
        xmppStream = XMPPStream()
        xmppStream.addDelegate(self, delegateQueue: dispatch_get_main_queue())
    }
    //MARK:激活各个模块
    private func activateModule() {
        self.activatevCard()
        self.activateRoster()
        self.messageActivate()
    }
    
    //MARK:设置各个模块
    private func setUPModule() {
        self.setUpXMPPStream()
        self.setupvCard()
        self.setupRoster()
        self.setupMessage()
    }
    //MARK:init
    override init() {
        super.init()
        self.setUPModule()
        self.activateModule()
        self.activateRoster()
    }
    
    //MARK:Login
    func userLogIn(loginDelegate : XMPPLoginDelegate?) {
        operationType = OperationType.LOGIN
        self.loginDelegate = loginDelegate
        self.connectTOHost()
    }
    
    //MARK:Register
    func userRegister(registerDelegate : XMPPRegisterDelegate?) {
        operationType = OperationType.REGISTER
        self.registerDelegate = registerDelegate
        self.connectTOHost()
    }
    
    
    
    //MARK:用户注销
    func userLogout() {
        xmppStream.disconnect()
        self.sendOffLineStateToHost()
        
    }
    
    //MARK:链接服务器
    private func connectTOHost() {
        //保护机制
        
        xmppStream.disconnect()
        
        var userName  = String()
        switch operationType! {
            case .LOGIN:
                userName = UserInfo.getInstance().userName
            case .REGISTER:
                userName = UserInfo.getInstance().registerUserName
        }
        
        xmppStream.myJID = XMPPJID.jidWithUser(userName, domain: "tarena.com", resource: "iphone")
        xmppStream.hostName = "localhost"
        do {
            try xmppStream.connectWithTimeout(XMPPStreamTimeoutNone)
        }catch let error as NSError {
            NSLog("链接错误\(error.localizedDescription)")
            switch operationType! {
            case .LOGIN:
                loginDelegate?.loginNetError()
            case .REGISTER:
                registerDelegate?.registerError()            }
        }
        
        
    }
    
    //MARK:XMPPStreamDelegate
    func xmppStreamDidConnect(sender: XMPPStream!) {
        
        switch operationType! {
        case .LOGIN:
            NSLog("链接成功,发送密码验证")
            self.sendPasswordAuthenticate()
            
        case .REGISTER:
            NSLog("发送密码注册")
            self.sendPasswordToRegister()
        }
        
        
    }
    
    
   
    func xmppStreamDidDisconnect(sender: XMPPStream!, withError error: NSError!) {
        NSLog("链接失败")
        
        
    }
    //MARK:发送密码验证
    func sendPasswordAuthenticate() {
        do {
            try xmppStream.authenticateWithPassword(UserInfo.getInstance().password)
        }catch let error as NSError {
            NSLog("密码验证错误\(error.localizedDescription)")
        }
    }
    
    func sendPasswordToRegister() {
        
        do {
            try xmppStream.registerWithPassword(UserInfo.getInstance().registerPassword)
        }catch let error as NSError {
            NSLog("注册错误\(error.localizedDescription)")
        }
        
    }
    
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
        NSLog("密码验证成功")
        //发送在线消息
        self.sendOnLineStateToHost()
        
    }
    
    func xmppStream(sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        NSLog("密码验证失败\(error.description)")
        loginDelegate?.loginFail()
    }
    
    func xmppStream(sender: XMPPStream!, didSendPresence presence: XMPPPresence!) {
        if presence.type() == onLineKeyWord {
            NSLog("用户已经上线")
            loginDelegate?.loginSuccess()
            
            
            
            
            
        }
    }
    
    
    //MARK:发送在线消息
    func sendOnLineStateToHost() {
        xmppStream.sendElement(XMPPPresence(type: onLineKeyWord))
    }
    //MARK:发送离线消息
    func sendOffLineStateToHost() {
        xmppStream.sendElement(XMPPPresence(type: offLineKeyWord))
    }
    
    
    
    func xmppStreamDidRegister(sender: XMPPStream!) {
        print("注册成功")
        registerDelegate?.registerSuccess()
        
    }
    
    func xmppStream(sender: XMPPStream!, didNotRegister error: DDXMLElement!) {
        print("注册失败")
        registerDelegate?.registerFail()
        
    }

    
    //当服务器有新的消息时自动调用
    func xmppStream(sender: XMPPStream!, didReceiveMessage message: XMPPMessage!) {
        NSLog("message =====> \(message)")
        
        //如果当前程序不在前台，发送一个本地通知
        if UIApplication.sharedApplication().applicationState != UIApplicationState.Active {
            NSLog("当前程序在后台")
            //本地通知
            let localNotification = UILocalNotification()
            //设置内容
            
            if let mess = message.body() {
                localNotification.alertBody = message.from().user + " 的消息: " + mess
            }
            
            //发送通知
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}















