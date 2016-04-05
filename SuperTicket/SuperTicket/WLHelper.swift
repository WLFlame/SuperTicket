//
//  WLHelper.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

typealias CancelableTask = (cancel: Bool) -> Void

extension String {
    func contains(find: String) -> Bool {
        return self.rangeOfString(find) != nil
    }
}

func delay(time: NSTimeInterval, work: dispatch_block_t) -> CancelableTask? {
    
    var finalTask: CancelableTask?
    
    let cancelableTask: CancelableTask = { cancel in
        if cancel {
            finalTask = nil
        } else {
            dispatch_async(dispatch_get_main_queue(), work)
        }
        
    }
    
    finalTask = cancelableTask
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
        if let task = finalTask {
            task(cancel: false)
        }
    }
    return finalTask
    
}

func cancel(cancelableTask: CancelableTask?) {
    cancelableTask?(cancel: true)
}

func unregisterThirdPartyPush() {
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
    })
}
/**
清空缓存
 */
func cleanRealmAndCaches() {
    
}

extension String {
    func stringByAppendingPathComponent(path: String) -> String {
        return (self as NSString).stringByAppendingPathComponent(path)
    }
}

func cleanDiskCacheFolder() {
    
    let folderPath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
    let fileMgr = NSFileManager.defaultManager()
    
    guard let fileArray = try? fileMgr.contentsOfDirectoryAtPath(folderPath) else {
        return
    }
    
    for filename in fileArray  {
        do {
            try fileMgr.removeItemAtPath(folderPath.stringByAppendingPathComponent(filename))
        } catch {
            print(" clean error ")
        }
        
    }
}


extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.hidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.hidden = false
    }
    
    func changeBottomHairImage() {
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if let view = view as? UIImageView where view.bounds.height <= 1.0 {
            return view
        }
        
        for subview in view.subviews {
            if let imageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
}













