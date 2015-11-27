
//
//  XMPPManager_vCard.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/20.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import Foundation

extension XMPPManager {
    
    func setupvCard() {
        xmppvCardStorage = XMPPvCardCoreDataStorage()
        xmppvCard = XMPPvCardTempModule(withvCardStorage: xmppvCardStorage)
        //创建头像模块对象
        avater = XMPPvCardAvatarModule(withvCardTempModule: xmppvCard)
    }
    
    func activatevCard() {
        xmppvCard.activate(xmppStream)
        //激活头像
        avater.activate(xmppStream)
    }
    
    var vCardUserInfo : XMPPvCardTemp! {
        get {
            guard xmppvCard.myvCardTemp != nil else {
                return XMPPvCardTemp(name: "vCard", xmlns: "vcard-temp")
            }
            return xmppvCard.myvCardTemp
        }
    }
    
    func updatevCardInfoToDataBase(vCardUserInfo : XMPPvCardTemp) {
        xmppvCard.updateMyvCardTemp(vCardUserInfo)
    }

    
    //创建头像模块，激活
    
    
    
    
}


























































