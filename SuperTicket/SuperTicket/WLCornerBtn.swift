//
//  WLCornerBtn.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/4.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class WLCornerBtn: UIButton {

    @IBInspectable var corner: CGFloat = 0.0
    override func awakeFromNib() {
        self.layer.cornerRadius = corner
        self.layer.masksToBounds = true
    }

}
