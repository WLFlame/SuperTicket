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
    @NSManaged var activityId: String!
    @NSManaged var nick: String!
    @NSManaged var signupPersonCount: NSNumber!
    @NSManaged var introduce: String?
    @NSManaged var isEnd: NSNumber!
    @NSManaged var timeSection: String?
    @NSManaged var httpEnable: NSNumber!
    @NSManaged var wifiEnable: NSNumber!
    @NSManaged var gpsEnable: NSNumber!
    @NSManaged var signInConfigure: SignInConfigure!
    @NSManaged var signInTimeSections: AVRelation!
    static func parseClassName() -> String! {
        return "Activity";
    }
}

func ==(lhs: Activity, rhs: Activity) -> Bool {
    return lhs.activityId == rhs.activityId
}

class SignInConfigure: AVObject, AVSubclassing {
    @NSManaged var BSSID: String!
    @NSManaged var SSID: String!
    @NSManaged var SSIDDATA: String!
    static func parseClassName() -> String! {
        return "SignInConfigure";
    }
}

class SignInTimeSection: AVObject, AVSubclassing {
    @NSManaged var name: String!
    @NSManaged var section: String!
    static func parseClassName() -> String! {
        return "SignInTimeSection";
    }
}