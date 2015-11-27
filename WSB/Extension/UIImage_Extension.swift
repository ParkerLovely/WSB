
//
//  UIImage_Extension.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/19.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

extension UIImage {
    class func stretchedIkmageWithName(name : String) ->UIImage {
        let image = UIImage(named: name)
        let leftCap = image!.size.width * 0.5
        let topCap = image!.size.height * 0.5
        let image2 = image?.stretchableImageWithLeftCapWidth(Int(leftCap), topCapHeight: Int(topCap))
        return image2!
    }
    
    
    class func resizeableImageWithEdge(name : String, top : CGFloat, left : CGFloat, bottom : CGFloat, right : CGFloat) ->UIImage {
        let image = UIImage(named: name)?.resizableImageWithCapInsets(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
        return image!
    }
}