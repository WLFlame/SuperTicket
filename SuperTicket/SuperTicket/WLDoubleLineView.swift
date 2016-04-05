//
//  WLDoubleLineView.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import Foundation

import UIKit
import SnapKit
@IBDesignable
class WLDoubleLineView: UIView {
    
    @IBInspectable var bottomlineLeading: Double = 0.0
    
    @IBInspectable var bottomlineTrigin: Double = 0.0
    
    @IBInspectable var bottomLineColor: String = ""
    
    @IBInspectable var toplineLeading: Double = 0.0
    
    @IBInspectable var toplineTrigin: Double = 0.0
    
    @IBInspectable var topLineColor: String = ""
    
    lazy var bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.hairLineColor()
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    lazy var topLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.hairLineColor()
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override func awakeFromNib() {
        addSubview(bottomLine)
        addSubview(topLine)
        bottomLine .snp_makeConstraints { (make) in
            make.left.equalTo(bottomlineLeading)
            make.right.equalTo(-bottomlineTrigin)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self)
        }
        topLine.snp_makeConstraints { (make) in
            make.left.equalTo(toplineLeading)
            make.right.equalTo(-toplineTrigin)
            make.height.equalTo(0.5)
            make.top.equalTo(self)
        }
        if !bottomLineColor.isEmpty {
            bottomLine.backgroundColor = UIColor(hexString: bottomLineColor)
        }
        if !topLineColor.isEmpty {
            topLine.backgroundColor = UIColor(hexString: topLineColor)
        }
    }
    
}
