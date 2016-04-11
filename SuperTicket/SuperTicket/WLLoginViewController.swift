//
//  WLLoginViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WLLoginViewController: UIViewController {

    @IBOutlet weak var fieldTel: UITextField!
    @IBOutlet weak var fielPwd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

   
    @IBAction func btnClickLogin(sender: AnyObject) {
        if !bindFields(fieldTel, fielPwd) {
            return
        }
        showHud()
        AVUser.logInWithUsernameInBackground(fieldTel.text, password: fielPwd.text) {[weak self] (user, error) in
            if error == nil {
                let avatar = user.objectForKey(k_AVATAR)
                var loginUser: LoginUser;
                if let avatar = avatar {
                     loginUser =  LoginUser(accessToken: user.username, userID:  user.objectId, username: user.username, nickname: user.username, avatarURLString: avatar as? String)
                } else {
                    loginUser = LoginUser(accessToken: user.username, userID:  user.objectId, username: user.username, nickname: user.username, avatarURLString: "")
                }
                saveTokenAndUserInfoOfLoginUser(loginUser)
                WLLinkUtil.sharedInstance.linkToMainVc()
                self?.hideHud()
            } else {
                asyncInMain{
                    self?.hideHud()
                    WLAlert.alertSorry(message: "登录失败", inViewController: self)
                }
            }
        }
    }

}
