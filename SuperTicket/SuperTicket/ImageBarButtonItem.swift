//
//  ImageBarButtonItem.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/11.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class ImageBarButtonItem: UIBarButtonItem {
    var imageBtn: UIButton!
    
    convenience init(image: UIImage, tap: ()->()) {
        self.init()
        imageBtn = UIButton()
        imageBtn.setImage(image, forState: .Normal)
        imageBtn.sizeToFit()
        imageBtn.touchUpInside{
            tap()
        }
        
        self.customView = imageBtn
    }
    
    override init() {
        super.init()
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
