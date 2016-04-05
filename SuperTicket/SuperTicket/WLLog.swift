//
//  WLLog.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import Foundation

func println(object: Any) {
    #if DEBUG
        Swift.print(object)
    #endif
}