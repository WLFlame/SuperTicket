//
//  WLLinkUtil.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/4.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import Foundation
import ImagePicker
enum ShowStyle {
    case Push, Modal, None
}

enum StoryBoardName: String {
    case Main = "Main"
    case Signup = "Signup"
    case Activity = "Activity"
}

class WLLinkUtil {
    static let sharedInstance = WLLinkUtil()
    
    var tabVc: WLTabbarController?
    
    var imagePicker: ImagePickerController?
    
    func linkToLoginVc(style: ShowStyle) {
        switch style {
        case .Push:
                UIApplication.sharedApplication().keyWindow?.topMostController().navigationController?.pushViewController(WLLoginViewController.createFromStoryBoard("Main", vcStroreId: "WLLoginViewController"), animated: true)
        case .Modal:
            UIApplication.sharedApplication().keyWindow?.topMostController().presentViewController(WLLoginViewController.createFromStoryBoard("Main", vcStroreId: "WLLoginViewController"), animated: true, completion: nil)
        default:
            UIApplication.sharedApplication().keyWindow?.rootViewController = WLNavigationController(rootViewController: WLLoginViewController.createFromStoryBoard("Main", vcStroreId: "WLLoginViewController"))
        }
    }
    
    func linkToLoginVc(attributes: [String : AnyObject]) {
        
    }
    
    func linkToMainVc() {
        let tabvc = WLTabbarController.createFromStoryBoard("Main", vcStroreId: "WLTabbarController") as? WLTabbarController
        self.tabVc = tabvc
        UIApplication.sharedApplication().keyWindow?.rootViewController = tabvc
    }
    
    func linkToCreateOrUpdateCompanyVc(send: UIViewController) {
        linkToCreateOrUpdateCompanyVc(send, company: nil)
    }
    
    func linkToCreateOrUpdateCompanyVc(send: UIViewController, company: Company?) {
        let vc = CreateCompanyViewController.createFromStoryBoard("Activity", vcStroreId: "CreateCompanyViewController") as! CreateCompanyViewController
        vc.company = company
        send.navigationController?.pushViewController(vc, animated: true)
    }
    
    func linkToChoseAvatarVc(send: ImagePickerDelegate) {
        let imagePickerController = ImagePickerController()
        self.imagePicker = imagePickerController
        imagePickerController.delegate = send
        imagePickerController.imageLimit = 1
        (send as? UIViewController)!.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func dismissAvatarVc() {
        if let imagePicker = imagePicker {
            imagePicker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func linkToCompanyDetailVc(send: UIViewController, company: Company) {
        let vc = CompanyDetailViewController.createFromStoryBoard(StoryBoardName.Activity.rawValue, vcStroreId: "CompanyDetailViewController") as! CompanyDetailViewController
        vc.company = company
        send.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


