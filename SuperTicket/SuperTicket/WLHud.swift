//
//  WLHud.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/7.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    func showHud() {
        let dimView = UIView(frame: view.bounds)
        dimView.backgroundColor = UIColor.flatBlackColor()
        dimView.alpha = 0.3
        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(origin: CGPoint(x: view.center.x - 75 / 4, y: view.center.y - 100) , size: CGSize(width: 75, height: 75)), type: .Pacman, color: UIColor.whiteColor(), size: CGSize(width: 75, height: 75))
        activityIndicatorView.startAnimation()
        self.view.addSubview(activityIndicatorView)
        view.addSubview(dimView)
        view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.tag = 1000
        dimView.tag = 1001
        
    }
    
    func hideHud() {
        (view.viewWithTag(1000) as? NVActivityIndicatorView)?.removeFromSuperview()
        view.viewWithTag(1001)?.removeFromSuperview()
    }
}