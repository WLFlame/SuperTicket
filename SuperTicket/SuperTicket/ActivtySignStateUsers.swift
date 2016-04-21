//
//  ActivtySignStateUsers.swift
//  SuperTicket
//
//  Created by ywl on 16/4/21.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
// 活动出勤表
class ActivtySignStateUsers: AVObject, AVSubclassing {
    @NSManaged var activityId: NSNumber!
    @NSManaged var signupUsers: [AVUser]!
    @NSManaged var notSignupUsers: [AVUser]!
    static func parseClassName() -> String! {
        return "ActivtySignStateUsers"
    }
}
