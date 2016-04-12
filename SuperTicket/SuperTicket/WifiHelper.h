//
//  WifiHelper.h
//  SuperTicket
//
//  Created by wanli.yang on 16/4/12.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLSingletonH.h"
//BSSID = "fc:d7:33:21:f4:f0";
//SSID = "TP-LINK_F4F0";
//SSIDDATA = <54502d4c 494e4b5f 46344630>;
#define K_BSSID @"BSSID"
#define K_SSID @"SSID"
#define K_SSIDDATA @"SSIDDATA"
@interface WifiHelper : NSObject
WLSingletonH(Helper)
- (NSString *)getWifiName;
- (NSDictionary *)getWifiInfo;
@end
