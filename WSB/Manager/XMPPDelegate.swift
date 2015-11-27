
//
//  XMPPDelegate.swift
//  WSB
//
//  Created by ParkerLovely on 15/11/20.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

import Foundation

protocol XMPPLoginDelegate {
    func loginSuccess()
    func loginFail()
    func loginNetError()
}

protocol XMPPRegisterDelegate {
    func registerSuccess()
    func registerFail()
    func registerError()
}

