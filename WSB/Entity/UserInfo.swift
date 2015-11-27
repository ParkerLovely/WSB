//
//  UserInfo.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/20.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit


let key_userName = "userName"
let key_userPassword = "userPassword"
let key_loginState = "loginState"

enum LoginState : Int {
    case Online = 0, Offline
}

class UserInfo: NSObject {

    var userName : String!
    var password : String!
    var loginState : LoginState!
    var registerUserName : String!
    var registerPassword : String!
    
    func saveInfo() {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(self.userName, forKey: key_userName)
        userDefaults.setObject(self.password, forKey: key_userPassword)
        userDefaults.setObject(self.loginState.rawValue, forKey: key_loginState)
        userDefaults.synchronize()
        
    }
    
    func loadUserInfoFromSandbox() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userName = userDefaults.stringForKey(key_userName)
        password = userDefaults.stringForKey(key_userPassword)
        if let state = userDefaults.objectForKey(key_loginState) as? Int {
            loginState = LoginState(rawValue: state)
        }else {
            loginState = LoginState(rawValue: 1)
        }
        
        
        
    }
    
    
    class func getInstance() ->UserInfo {
        struct Singleton {
            static var predicate : dispatch_once_t = 0
            static var userInfo : UserInfo!
        }
        dispatch_once(&Singleton.predicate) { () -> Void in
            Singleton.userInfo = UserInfo()
        }
        return Singleton.userInfo
    }
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
}
