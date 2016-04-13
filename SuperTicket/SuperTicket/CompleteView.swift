//
//  QZCompleteView.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/14.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class CompleteView: UIView {

    override func awakeFromNib() {
        frame = CGRect(x: 0, y: 0, width: UIScreen.width(), height: 44)
    }
    
    var completeBlock: (() -> Void)!
    
  
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func clickComplete(sender: AnyObject) {
        completeBlock()
    }

}
