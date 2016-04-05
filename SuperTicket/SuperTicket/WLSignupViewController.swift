//
//  QZSignupViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import ChameleonFramework

class WLSignupViewController: UIViewController {

    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbSubTime: UILabel!
    @IBOutlet weak var activityChoicePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}

// MARK: - Action Method
extension WLSignupViewController {
    // 活动说明
    @IBAction func actSummary(sender: AnyObject) {
        
    }
    
    // 签到情况
    @IBAction func signupState(sender: AnyObject) {
        
    }
    
    // 本次活动任务
    @IBAction func actAssignment(sender: AnyObject) {
        
    }
    
    // 提交电子票
    @IBAction func submitTicket(sender: AnyObject) {
        
    }

    // 活动聊天室
    @IBAction func actChatRoom(sender: AnyObject) {
        
    }
}

// MARK: - UIPickerViewDataSource
extension WLSignupViewController : UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
}

// MARK: - UIPickerViewDelegate
extension WLSignupViewController : UIPickerViewDelegate {

    
}



