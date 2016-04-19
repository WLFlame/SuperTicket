//
//  Activity.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/12.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import Foundation
//#define K_BSSID @"BSSID"
//#define K_SSID @"SSID"
//#define K_SSIDDATA @"SSIDDATA"
class Activity: AVObject, AVSubclassing {
    // 活动id
    @NSManaged var activityId: NSNumber!
    // 公司id
    @NSManaged var companyId: NSNumber!
    // 活动名称
    @NSManaged var nick: String!
    // 报名人数
    @NSManaged var signupCount: NSNumber!
    //
    @NSManaged var signupPersonCount: NSNumber!
    // 介绍
    @NSManaged var introduce: String?
    // 是否结束
    @NSManaged var isEnd: NSNumber!
    // 开始时间
    @NSManaged var startTimeDate: NSDate?
    // 结束时间
    @NSManaged var endTimeDate: NSDate?
    // 是否支持http验证
    @NSManaged var httpEnable: NSNumber!
    // 是否支持wifi验证
    @NSManaged var wifiEnable: NSNumber!
    // 是否支持gps验证
    @NSManaged var gpsEnable: NSNumber!
    // 验证配置
    @NSManaged var signInConfigure: SignInConfigure?
    // 验证有效时间段
    @NSManaged var signInTimeSections: [SignInTimeSection]!
    // 验证有效位置
    @NSManaged var signInLocation: SignInLocation?
    // 发布人id
    @NSManaged var publisherId: String!
    // 活动任务
    @NSManaged var assignment: String?
    
    static func parseClassName() -> String! {
        return "Activity";
    }
}

func ==(lhs: Activity, rhs: Activity) -> Bool {
    return lhs.activityId == rhs.activityId
}

class SignInLocation: AVObject, AVSubclassing {
    @NSManaged var activityId: NSNumber!
    @NSManaged var name: String!
    @NSManaged var latitude: NSNumber!
    @NSManaged var longtitude: NSNumber!
    static func parseClassName() -> String! {
        return "SignInLocation"
    }
}

class SignInConfigure: AVObject, AVSubclassing {
    @NSManaged var activityId: NSNumber!
    @NSManaged var BSSID: String!
    @NSManaged var SSID: String!
    @NSManaged var SSIDDATA: NSData!
    static func parseClassName() -> String! {
        return "SignInConfigure";
    }
}

class SignInTimeSection: AVObject, AVSubclassing {
    @NSManaged var activityId: NSNumber!
    @NSManaged var id: String!
    @NSManaged var name: String!
    @NSManaged var startTime: NSDate!
    @NSManaged var endTime: NSDate!
    static func parseClassName() -> String! {
        return "SignInTimeSection";
    }
}