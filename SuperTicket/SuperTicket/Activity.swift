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
    @NSManaged var activityId: NSNumber!
    @NSManaged var companyId: NSNumber!
    @NSManaged var nick: String!
    @NSManaged var signupCount: NSNumber!
    @NSManaged var signupPersonCount: NSNumber!
    @NSManaged var introduce: String?
    @NSManaged var isEnd: NSNumber!
    @NSManaged var startTimeDate: NSDate?
    @NSManaged var endTimeDate: NSDate?
    @NSManaged var httpEnable: NSNumber!
    @NSManaged var wifiEnable: NSNumber!
    @NSManaged var gpsEnable: NSNumber!
    @NSManaged var signInConfigure: SignInConfigure?
    @NSManaged var signInTimeSections: [SignInTimeSection]!
    @NSManaged var signInLocation: SignInLocation?
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