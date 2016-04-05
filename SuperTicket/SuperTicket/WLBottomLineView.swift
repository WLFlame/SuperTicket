//
//  WLBottomLineView.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import SnapKit
@IBDesignable
class WLBottomLineView: UIView {
    
    @IBInspectable var lineLeading: Double = 0.0
    
    @IBInspectable var lineTrigin: Double = 0.0
    
    @IBInspectable var bottomLineColor: String = ""
    
    lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.hairLineColor()
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    override func awakeFromNib() {
        addSubview(bottomLine)
        bottomLine .snp_makeConstraints { (make) in
            make.left.equalTo(lineLeading)
            make.right.equalTo(-lineTrigin)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self)
        }
        if !bottomLineColor.isEmpty {
            bottomLine.backgroundColor = UIColor(hexString: bottomLineColor)
        }
    }
    
}
