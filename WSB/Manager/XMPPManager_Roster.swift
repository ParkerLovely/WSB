
//
//  XMPPManager_Roster.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/21.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import Foundation

extension XMPPManager : XMPPRosterDelegate {
 
    
    func setupRoster() {
        
        rosterStorage = XMPPRosterCoreDataStorage()
        roster = XMPPRoster(rosterStorage: rosterStorage)
        roster.addDelegate(self, delegateQueue: dispatch_get_main_queue())
        
    }
    
    func activateRoster() {
       
        roster.activate(xmppStream)
    }
    
    
    func getRosterCoreDataContext() ->NSManagedObjectContext {
        return rosterStorage.mainThreadManagedObjectContext
    }
    
    //判断好友是否已经存在
    func userExistsWithJid(friendJid : XMPPJID) ->Bool {
        return rosterStorage.userExistsWithJID(friendJid, xmppStream: xmppStream)
    }
    //添加好友
    func addFriend(friendJid : XMPPJID) {
        roster.subscribePresenceToUser(friendJid)
    }
    //删除好友
    func removeFriend(friendJid : XMPPJID) {
        roster.removeUser(friendJid)
    }
    
    
    //添加好友验证
    func xmppRoster(sender: XMPPRoster!, didReceivePresenceSubscriptionRequest presence: XMPPPresence!) {
        //验证
        roster.acceptPresenceSubscriptionRequestFrom(presence.from(), andAddToRoster: true)
        //拒绝
        //roster.rejectPresenceSubscriptionRequestFrom(presence.from())
    }
    
    
    
    
}




