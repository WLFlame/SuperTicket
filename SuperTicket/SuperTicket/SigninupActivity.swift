//
//  SigninupActivity.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/16.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import Foundation

let k_SignInActivities = "signInActivities"
let k_userId = "userId"
class SigninupActivity: AVObject, AVSubclassing {
    @NSManaged var userId: String!
    @NSManaged var signInActivities: [String]!
    static func parseClassName() -> String! {
        return "SigninupActivity"
    }
}