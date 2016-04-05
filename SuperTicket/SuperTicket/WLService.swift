//
//  WLService.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import Foundation
 /// 主机地址
let baseURL = NSURL(string: "")

struct LoginUser: CustomStringConvertible {
    let accessToken: String
    let userID: String
    let username: String?
    let nickname: String
    let avatarURLString: String?
    
    var description: String {
        return "LoginUser(accessToken: \(accessToken), userID: \(userID), nickname: \(nickname), avatarURLString: \(avatarURLString))"
    }
}

func saveTokenAndUserInfoOfLoginUser(loginUser: LoginUser) {
    WLUserDefaults.userID.value = loginUser.userID
    WLUserDefaults.nickname.value = loginUser.nickname
    WLUserDefaults.avatarURLString.value = loginUser.avatarURLString
    
    WLUserDefaults.v1AccessToken.value = loginUser.accessToken
}