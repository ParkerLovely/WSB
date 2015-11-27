//
//  UIButton_Extension.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/19.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit


extension UIButton {
    func setStretchedBG(imageName : String) {
        self.setBackgroundImage(UIImage.resizeableImageWithEdge(imageName, top: 10, left: 10, bottom: 37, right: 34), forState: UIControlState.Normal)
    }
}

