//
//  WLSendVerifyCodeControlelr.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/4.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class WLSendVerifyCodeControlelr: UIViewController {

    @IBOutlet weak var btnSendVerifyCode: QZVerifyCodeBtn!
    @IBOutlet weak var fieldTel: UITextField!
    @IBOutlet weak var fieldVerifyCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSendVerifyCode.didTouchBegan = { [weak self] in
            return (self?.sendVerify())!
        }
    }
    
    // 发送验证码
    private func sendVerify() -> Bool{
        guard let tel = fieldTel.text else {
            WLAlert.alertSorry(message: "请输入手机号", inViewController: self)
            return false
        }
        
        if !tel.isMobileNumber() {
            WLAlert.alertSorry(message: "请输入正确手机号", inViewController: self)
            return false
        }
        AVOSCloud.requestSmsCodeWithPhoneNumber(tel) { (succeeded, error) in
            if succeeded {
               
            } else {
                WLAlert.alertSorry(message: "请求验证码失败", inViewController: self)
            }
        }
        return true
        
    }

    @IBAction func sendVerifyCode(sender: AnyObject) {
        
    }

    @IBAction func nextStep(sender: AnyObject) {
        guard let tel = fieldTel.text else {
            WLAlert.alertSorry(message: "请输入手机号", inViewController: self)
            return
        }
        guard let verifyCode = fieldVerifyCode.text else {
            WLAlert.alertSorry(message: "请输入验证码", inViewController: self)
            return
        }
        
        AVOSCloud.verifySmsCode(verifyCode, mobilePhoneNumber: tel) { [weak self] (succeed, error) in
            if succeed {
                self?.performSegueWithIdentifier("segue_register", sender: nil)
            }
        }
    }
    
}
