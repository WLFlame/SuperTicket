//
//  QZVerifyCodeBtn.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/4.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class QZVerifyCodeBtn: UIButton {
    var timer: NSTimer?
    
    let MAX_SECONDS = 60
    var timeMaxSeconds = 60
    var didTouchBegan: (() -> Bool)?
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        if didTouchBegan != nil {
            if didTouchBegan!() {
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(QZVerifyCodeBtn.changeTimeSeconds), userInfo: nil, repeats: true)
                enabled = false
            }
        }
    }

    func changeTimeSeconds() {
        if timeMaxSeconds > 0 {
            timeMaxSeconds -= 1
            setTitle("\(timeMaxSeconds)s后重试", forState: .Normal)
        } else {
            timer!.invalidate()
            timeMaxSeconds = 60
            setTitle("发送验证码", forState: .Normal)
        }
    }
}
