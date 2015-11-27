//
//  InputView.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/23.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import UIKit

class InputView: UIView {
    
    @IBOutlet weak var chatTextView: UITextView!

    class func chatInputView() ->InputView {
        let bundle = NSBundle.mainBundle().loadNibNamed("InuptView", owner: nil, options: nil)
        return bundle.last as! InputView
    }
    
   
}
