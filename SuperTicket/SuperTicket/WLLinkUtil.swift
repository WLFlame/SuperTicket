//
//  WLLinkUtil.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/4.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import Foundation

enum ShowStyle {
    case Push, Modal, None
}

class WLLinkUtil {
    static let sharedInstance = WLLinkUtil()
    
    func linkToLoginVc(style: ShowStyle) {
        switch style {
        case .Push:
                UIApplication.sharedApplication().keyWindow?.topMostController().navigationController?.pushViewController(WLLoginViewController.createFromStoryBoard("Main", vcStroreId: "WLLoginViewController"), animated: true)
        case .Modal:
            UIApplication.sharedApplication().keyWindow?.topMostController().presentViewController(WLLoginViewController.createFromStoryBoard("Main", vcStroreId: "WLLoginViewController"), animated: true, completion: nil)
        default:
            UIApplication.sharedApplication().keyWindow?.rootViewController = WLNavigationController(rootViewController: WLLoginViewController.createFromStoryBoard("Main", vcStroreId: "WLLoginViewController"))
        }
    }
    
    func linkToLoginVc(attributes: [String : AnyObject]) {
        
    }
}