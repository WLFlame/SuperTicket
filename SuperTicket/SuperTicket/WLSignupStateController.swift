//
//  WLSignupStateController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import PagingMenuController

class WLSignupStateController: UIViewController {
    var activity: Activity!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        title = "签到情况"
        view.backgroundColor = UIColor.whiteColor()
        view.backgroundColor = UIColor.whiteColor()
        
        let viewController = QZSignedTableViewController()
        viewController.title = "已签"
        
        let viewController2 = QZUnSignedTableViewController()
        viewController2.title = "未签"
        
        let viewControllers = [viewController, viewController2]
        
        let options = PagingMenuOptions()
        options.menuItemMargin = 5
        options.menuHeight = 60
        options.menuDisplayMode = .SegmentedControl
        let pagingMenuController = PagingMenuController(viewControllers: viewControllers, options: options)
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)
    }

}
