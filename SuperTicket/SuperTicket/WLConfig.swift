//
//  WLConfig.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import CoreLocation

class WLConfig {
    class func clientType() -> Int {
        // TODO: clientType
        
        #if DEBUG
            return 2
        #else
            return 0
        #endif
    }
    
    static let termsURLString = "http://privacy.soyep.com"
    static let appURLString = "itms-apps://itunes.apple.com/app/id" + "983891256"
    
    struct Notification {
//        static let 
    }
    
    struct Location {
        static let distanceThreshold: CLLocationDistance = 500
    }
    
}

// MARK: - 第三方
extension WLConfig {
    struct LeanCloudKey {
        static let appId = "rQQyTd1oV8uQXaBLHFElufJ1-gzGzoHsz"
        static let clientKey = "FYQwJetEyNcvhprE2sbvY0ac"
    }
}

extension UIFont {
    class func rightItemFont() -> UIFont {
        return UIFont.systemFontOfSize(15)
    }

}


extension UIColor {
    class func hairLineColor() -> UIColor {
        return UIColor(hexString: "#d2d2d2")
    }
    
    class func themeColor() -> UIColor {
        return UIColor(hexString: "#9DA9FF")
    }
    
    class func rightItemTitleColor() -> UIColor {
        return UIColor.whiteColor()
    }
}
