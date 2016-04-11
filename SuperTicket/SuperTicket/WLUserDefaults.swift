//
//  WLUserDefaults.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

let v1AccessTokenKey = "v1AccessToken"
let userIDKey = "userID"
let nicknameKey = "nickname"
let introductionKey = "introduction"
let avatarURLStringKey = "avatarURLString"
let badgeKey = "badge"
let pusherIDKey = "pusherID"

let areaCodeKey = "areaCode"
let mobileKey = "mobile"

let discoveredUserSortStyleKey = "discoveredUserSortStyle"
let feedSortStyleKey = "feedSortStyle"

let latitudeShiftKey = "latitudeShift"
let longitudeShiftKey = "longitudeShift"

let userLocationNameKey = "userLocationName"


struct Listener<T>: Hashable {
    let name: String
    
    typealias Action = T -> Void
    let action: Action
    
    var hashValue: Int {
        return name.hashValue
    }
}

func ==<T>(lhs: Listener<T>, rhs: Listener<T>) -> Bool {
    return lhs.name == rhs.name
}

class Listenable<T> {
    var value: T {
        didSet {
            setterAction(value)
            
            for listener in listenerSet {
                listener.action(value)
            }
        }
    }
    
    typealias SetterAction = T -> Void
    var setterAction: SetterAction
    
    var listenerSet = Set<Listener<T>>()
    
    func bindListener(name: String, action: Listener<T>.Action) {
        let listener = Listener(name: name, action: action)
        
        listenerSet.insert(listener)
    }
    
    func bindAndFireListener(name: String, action: Listener<T>.Action) {
        bindListener(name, action: action)
        action(value)
    }
    
    func removeListenerWithName(name: String) {
        for listener in listenerSet {
            if listener.name == name {
                listenerSet.remove(listener)
                break
            }
        }
    }
    
    func removeAllListeners() {
        listenerSet.removeAll(keepCapacity: false)
    }
    
    init(_ v: T, setterAction action: SetterAction) {
        value = v
        setterAction = action
    }

}


class WLUserDefaults {
    static let defaults = NSUserDefaults()
    
    static var isLogined: Bool {
        if let _ = WLUserDefaults.v1AccessToken.value {
            return true
        } else {
            return false
        }
    }
    
    class func cleanAllUserDefaults() {
        v1AccessToken.removeAllListeners()
        userID.removeAllListeners()
        nickname.removeAllListeners()
        introduction.removeAllListeners()
        avatarURLString.removeAllListeners()
        mobile.removeAllListeners()
        latitudeShift.removeAllListeners()
        longitudeShift.removeAllListeners()
        userLocationName.removeAllListeners()
    }
    
    class func userNeedRelogin() {
        if let _ = v1AccessToken.value {
            // 清楚磁盘缓存
            cleanRealmAndCaches()
            
            cleanAllUserDefaults()
            if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                if let rootViewController = appDelegate.window?.rootViewController {
                    WLAlert.alert(title: "抱歉", message: "用户授权失败, 需要重新登陆", dismissTitle: "重新登录", inViewController: rootViewController, withDismissAction: { () -> Void in
                        // 切换控制器
//                        appDelegate.startShowStory()
                    })
                }
            }
        }
    }
    
    static var v1AccessToken: Listenable<String?> = {
        let v1AccessToken = defaults.stringForKey(v1AccessTokenKey)
        return Listenable<String?>(v1AccessToken) {_ in 
             defaults.setObject(userID.value, forKey: v1AccessTokenKey)
        }
    }()
    
    static var userID: Listenable<String?> = {
        let userID = defaults.stringForKey(userIDKey)
        
        return Listenable<String?>(userID) { userID in
            defaults.setObject(userID, forKey: userIDKey)
        
        }
    }()
    
    static var nickname: Listenable<String?> = {
        let nickname = defaults.stringForKey(nicknameKey)
        
        return Listenable<String?>(nickname) { nickname in
            defaults.setObject(nickname, forKey: nicknameKey)
        }
    }()
    
    static var introduction: Listenable<String?> = {
        let introduction = defaults.stringForKey(introductionKey)
        return Listenable<String?>(introduction) { introduction in
            defaults.setObject(introduction, forKey: introductionKey)
        }
    }()
    
    static var avatarURLString: Listenable<String?> = {
        let avatarURLString = defaults.stringForKey(avatarURLStringKey)
        return Listenable<String?>(avatarURLString) { avatarURLString in
            defaults.setObject(avatarURLString, forKey: avatarURLStringKey)
        }
    }()
    
    static var mobile: Listenable<String?> = {
        let mobile = defaults.stringForKey(mobileKey)
        
        return Listenable<String?>(mobile) { mobile in
            defaults.setObject(mobile, forKey: mobileKey)
        }
    }()
    
    static var latitudeShift: Listenable<Double?> = {
        let latitudeShift = defaults.doubleForKey(latitudeShiftKey)
        
        return Listenable<Double?>(latitudeShift) { latitudeShift in
            defaults.setObject(latitudeShift, forKey: latitudeShiftKey)
        }
    }()
    
    static var longitudeShift: Listenable<Double?> = {
        let longitudeShift = defaults.doubleForKey(longitudeShiftKey)
        
        return Listenable<Double?>(longitudeShift) { longitudeShift in
            defaults.setObject(longitudeShift, forKey: longitudeShiftKey)
        }
    }()
    
    static var userLocationName: Listenable<String?> = {
        let userLocationName = defaults.stringForKey(userLocationNameKey)
        
        return Listenable<String?>(userLocationName) { userLocationName in
            defaults.setObject(userLocationName, forKey: userLocationNameKey)
        }
    }()
}
















