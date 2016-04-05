//
//  WLAlert.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class WLAlert {
    class func alert(title title: String, message: String?, dismissTitle: String, inViewController viewController: UIViewController?, withDismissAction dismissAction: (() -> Void)?) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .Default) { action -> Void in
                if let dismissAction = dismissAction {
                    dismissAction()
                }
            }
            alertController.addAction(action)
            
            viewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    class func alertSorry(message message: String?, inViewController viewController: UIViewController?, withDismissAction dismissAction: () -> Void) {
        alert(title: "抱歉", message: message, dismissTitle: "确定", inViewController: viewController, withDismissAction: dismissAction)
    }
    
    class func alertSorry(message message: String?, inViewController viewController: UIViewController?) {
        alert(title: "抱歉", message: message, dismissTitle: "确定", inViewController: viewController, withDismissAction: nil)
    }
    
    class func textInput(title title: String, placeholder: String?, oldText: String?, dismissTitle: String, inViewController viewController: UIViewController?, withFinishedAction finishedAction: ((text: String) -> Void)?) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
            
            alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
                textField.placeholder = placeholder
                textField.text = oldText
            }
            
            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .Default) { action -> Void in
                if let finishedAction = finishedAction {
                    if let textField = alertController.textFields?.first, text = textField.text {
                        finishedAction(text: text)
                    }
                }
            }
            alertController.addAction(action)
            
            viewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    class func textInput(title title: String, message: String?, placeholder: String?, oldText: String?, confirmTitle: String, cancelTitle: String, inViewController viewController: UIViewController?, withConfirmAction confirmAction: ((text: String) -> Void)?, cancelAction: (() -> Void)?) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
                textField.placeholder = placeholder
                textField.text = oldText
            }
            
            let _cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .Cancel) { action -> Void in
                cancelAction?()
            }
            alertController.addAction(_cancelAction)
            
            let _confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .Default) { action -> Void in
                if let textField = alertController.textFields?.first, text = textField.text {
                    confirmAction?(text: text)
                }
            }
            alertController.addAction(_confirmAction)
            
            viewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    class func confirmOrCancel(title title: String, message: String, confirmTitle: String, cancelTitle: String, inViewController viewController: UIViewController?, withConfirmAction confirmAction: () -> Void, cancelAction: () -> Void) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .Cancel) { action -> Void in
                cancelAction()
            }
            alertController.addAction(cancelAction)
            
            let confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .Default) { action -> Void in
                confirmAction()
            }
            alertController.addAction(confirmAction)
            
            viewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
}

extension UIViewController {
    func alertCanNotAccessCameraRoll() {
        
        dispatch_async(dispatch_get_main_queue()) {
            WLAlert.confirmOrCancel(title: "抱歉", message: "不能访问您的相册！\n但您可以在iOS设置里修改设定。", confirmTitle: "现在改变", cancelTitle: "取消", inViewController: self, withConfirmAction: {
                
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                
                }, cancelAction: {
            })
        }
    }
    
    func alertCanNotOpenCamera() {
        
        dispatch_async(dispatch_get_main_queue()) {
            WLAlert.confirmOrCancel(title: NSLocalizedString("Sorry", comment: ""), message: NSLocalizedString("Yep can not open your Camera!\nBut you can change it in iOS Settings.", comment: ""), confirmTitle: NSLocalizedString("Change it now", comment: ""), cancelTitle: NSLocalizedString("Dismiss", comment: ""), inViewController: self, withConfirmAction: {
                
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                
                }, cancelAction: {
            })
        }
    }
    
    func alertCanNotAccessMicrophone() {
        
        dispatch_async(dispatch_get_main_queue()) {
            WLAlert.confirmOrCancel(title: NSLocalizedString("Sorry", comment: ""), message: NSLocalizedString("Yep can not access your Microphone!\nBut you can change it in iOS Settings.", comment: ""), confirmTitle: NSLocalizedString("Change it now", comment: ""), cancelTitle: NSLocalizedString("Dismiss", comment: ""), inViewController: self, withConfirmAction: {
                
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                
                }, cancelAction: {
            })
        }
    }
    
    func alertCanNotAccessContacts() {
        
        dispatch_async(dispatch_get_main_queue()) {
            WLAlert.confirmOrCancel(title: NSLocalizedString("Sorry", comment: ""), message: NSLocalizedString("Yep can not read your Contacts!\nBut you can change it in iOS Settings.", comment: ""), confirmTitle: NSLocalizedString("Change it now", comment: ""), cancelTitle: NSLocalizedString("Dismiss", comment: ""), inViewController: self, withConfirmAction: {
                
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                
                }, cancelAction: {
            })
        }
    }
    
    func alertCanNotAccessLocation() {
        
        dispatch_async(dispatch_get_main_queue()) {
            WLAlert.confirmOrCancel(title: NSLocalizedString("Sorry", comment: ""), message: NSLocalizedString("Yep can not get your Location!\nBut you can change it in iOS Settings.", comment: ""), confirmTitle: NSLocalizedString("Change it now", comment: ""), cancelTitle: NSLocalizedString("Dismiss", comment: ""), inViewController: self, withConfirmAction: {
                
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                
                }, cancelAction: {
            })
        }
    }
    
    
    func showProposeMessageIfNeedForContactsAndTryPropose(propose: Propose) {
        
        if PrivateResource.Contacts.isNotDeterminedAuthorization {
            
            dispatch_async(dispatch_get_main_queue()) {
                
                WLAlert.confirmOrCancel(title: NSLocalizedString("Notice", comment: ""), message: NSLocalizedString("Yep need to read your Contacts to continue this operation.\nIs that OK?", comment: ""), confirmTitle: NSLocalizedString("OK", comment: ""), cancelTitle: NSLocalizedString("Not now", comment: ""), inViewController: self, withConfirmAction: {
                    
                    propose()
                    
                    }, cancelAction: {
                })
            }
            
        } else {
            propose()
        }
    }
}











