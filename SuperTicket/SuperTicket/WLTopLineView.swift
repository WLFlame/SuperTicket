//
//  WLTopLineView.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import SnapKit
@IBDesignable
class WLTopLineView: UIView {
    
    @IBInspectable var toplineLeading: Double = 0.0
    
    @IBInspectable var toplineTrigin: Double = 0.0
    
    @IBInspectable var topLineColor: String = ""
    
    lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.hairLineColor()
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override func awakeFromNib() {
        addSubview(bottomLine)
        bottomLine .snp_makeConstraints { (make) in
            make.left.equalTo(toplineLeading)
            make.right.equalTo(-toplineTrigin)
            make.height.equalTo(0.5)
            make.top.equalTo(self)
        }
        if !topLineColor.isEmpty {
            bottomLine.backgroundColor = UIColor(hexString: topLineColor)
        }
    }
    
}
