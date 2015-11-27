
//
//  Define.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/19.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

func toCGFloatColor(number : Int) ->CGFloat {
    return CGFloat(Double(number) / 255.0)
}

func getUIColor(red red : Int, green : Int, blue : Int, alpha : CGFloat) ->UIColor {
    
    return UIColor(red: toCGFloatColor(red), green: toCGFloatColor(green), blue: toCGFloatColor(blue), alpha: alpha)
    
    
}


let loginButtonImageName = "button"
let loginHeadImageFrame = getUIColor(red: 213, green: 115, blue: 8, alpha: 1.0)

//登录对话框颜色
let loginProgressHUDColor = getUIColor(red: 92, green: 57, blue: 73, alpha: 1)