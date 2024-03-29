//
//  AppDelegate.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/18.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

protocol DataRefreshDelegate{
    func dataRefresh()
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, XMPPLoginDelegate {

    var window: UIWindow?

    var dataRefresh_delegate : DataRefreshDelegate?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
//        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
//        print("\(path)")
        
        
        UserInfo.getInstance().loadUserInfoFromSandbox()
        
        if UserInfo.getInstance().loginState == LoginState.Online {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController() as? UITabBarController
            self.window!.rootViewController = vc
            MBProgressHUD.showMessage("读取数据...", toView: self.window!.rootViewController!.view, color: loginProgressHUDColor)
            XMPPManager.getInstance().userLogIn(self)
            
            let naVc = vc?.viewControllers![0] as? UINavigationController
            let contactsVc = naVc?.topViewController as? ContactTableViewController
            self.dataRefresh_delegate = contactsVc
            
            
            //注册本地通知
            let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil)
            application.registerUserNotificationSettings(settings)
            
        }
        
        
        
        
        return true
    }

    
    func loginSuccess() {
        MBProgressHUD.hideHUDForView(self.window?.rootViewController?.view)
        //登录成功刷新界面
        dataRefresh_delegate?.dataRefresh()
    }
    func loginFail() {
        MBProgressHUD.hideHUDForView(self.window?.rootViewController?.view)
    }
    func loginNetError() {
        MBProgressHUD.hideHUDForView(self.window?.rootViewController?.view)
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

