//
//  XMPPManager_message.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/23.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import Foundation

extension XMPPManager {
    func setupMessage() {
        msgStorage = XMPPMessageArchivingCoreDataStorage()
        msgArchiving = XMPPMessageArchiving(messageArchivingStorage: msgStorage)
    }
    func messageActivate() {
        //激活
        msgArchiving.activate(xmppStream)
    }
    
    //获取上下文环境
    func  getMessageCoreDataContext() ->NSManagedObjectContext {
        return msgStorage.mainThreadManagedObjectContext
    }
    
    
    //发送消息
    func sendMessage(text : String, msgType : String, jid : XMPPJID) {
        let msg = XMPPMessage(type: msgType, to: jid)
      
        msg.addBody(text)
        xmppStream.sendElement(msg)
    }

    
}