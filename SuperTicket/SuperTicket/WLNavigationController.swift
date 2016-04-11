//
//  WLNavigationController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class WLNavigationController: UINavigationController {
    var isAnimation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer!.delegate = nil
    }
    
    lazy var backBtn: UIButton = {
        //设置返回按钮属性
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.setImage(UIImage(named: "back"), forState: .Normal)
        backBtn.titleLabel?.hidden = true
        backBtn.addTarget(self, action: #selector(WLNavigationController.backBtnClick), forControlEvents: .TouchUpInside)
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let btnW: CGFloat = 50
        backBtn.frame = CGRectMake(0, 0, btnW, 40)
        
        return backBtn
    }()
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.hidesBackButton = true
        if childViewControllers.count > 0 {
            
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            
            WLLinkUtil.sharedInstance.tabVc?.animationTabBarHidden(true)
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func backBtnClick() {
        popViewControllerAnimated(isAnimation)
        WLLinkUtil.sharedInstance.tabVc?.animationTabBarHidden(false)
    }
    
}
