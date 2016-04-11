//
//  TitleBarButtonItem.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/11.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class TitleBarButtonItem: UIBarButtonItem {
   var titleBtn: UIButton!
    
    convenience init(title: String, tap: ()->()) {
        self.init()
        titleBtn = UIButton()
        titleBtn.setTitle(title, forState: .Normal)
        titleBtn.setTitleColor(UIColor.rightItemTitleColor(), forState: .Normal)
        titleBtn.titleLabel?.font = UIFont.rightItemFont()
        titleBtn.sizeToFit()
        titleBtn.touchUpInside{
            tap()
        }
        
        self.customView = titleBtn
    }
    
    override init() {
        super.init()
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
