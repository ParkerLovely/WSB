
//
//  UIView_Extension.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/19.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

extension UIView {
    private func changeCorner(cornerRadius : CGFloat, borderWidth : CGFloat, borderColr : UIColor) {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColr.CGColor
        layer.borderWidth = borderWidth
    }
    //封装内容
    func setLayer(cornerRadius : CGFloat, borderWidth : CGFloat, borderColr : UIColor) {
        self.changeCorner(cornerRadius, borderWidth: borderWidth, borderColr: borderColr)
    }
    func round() {
        self.setLayer(self.bounds.size.width * 0.5, borderWidth: 2, borderColr:loginHeadImageFrame)
    }
    func roundRect() {
        self.setLayer(self.bounds.size.width * 0.05, borderWidth: 2, borderColr:loginHeadImageFrame)
    }
    
}