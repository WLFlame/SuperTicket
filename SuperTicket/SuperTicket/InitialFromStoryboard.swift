//
//  InitialFromStoryboard.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/4.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import Foundation


protocol InitialFromStoryboard : class {
    static func createFromStoryBoard(storeId: String, vcStroreId: String) -> UIViewController
}

extension UIViewController : InitialFromStoryboard {
    static func createFromStoryBoard(storeId: String, vcStroreId: String) -> UIViewController {
        return UIStoryboard(name: storeId, bundle: nil).instantiateViewControllerWithIdentifier(vcStroreId) 
    }
}

