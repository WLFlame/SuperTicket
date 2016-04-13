//
//  DatePickerView.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/14.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class DatePickerView: UIView {

    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
