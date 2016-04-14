//
//  ChoseWifiViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/14.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class ChoseWifiViewController: UITableViewController {
    var activity: Activity!
    
    @IBOutlet weak var fdWifiSSD: UITextField!
    @IBOutlet weak var lbLocation: UILabel!
    
    @IBAction func btnClickRefreshWifi(sender: AnyObject) {
        showHud()
         let info = WifiHelper.sharedHelper().getWifiInfo()
        hideHud()
        if let ssid = info[K_SSID] {
            WLAlert.confirmOrCancel(title: "提示", message: "是否将wifi \(ssid) 作为签到wifi", confirmTitle: "确定", cancelTitle: "取消", inViewController: self, withConfirmAction: {[weak self] in
                let configure = SignInConfigure()
                configure.BSSID = info[K_BSSID] as! String
                configure.SSID = info[K_SSID] as! String
                configure.SSIDDATA = info[K_SSIDDATA] as! String
                self?.activity.signInConfigure = configure
            }) {
                
            }
        }
        
    }
}

extension ChoseWifiViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
