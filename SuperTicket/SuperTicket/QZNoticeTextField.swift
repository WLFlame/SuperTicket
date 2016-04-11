//
//  QZNoticeTextField.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/7.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

extension UITextField {
    func check() -> Bool{
        if text!.isEmpty {
            let alert = UIAlertView(title: "提示", message: placeholder, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return false
        }
        return true
    }
}
