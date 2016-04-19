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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择签到wifi和签到地点"
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let locName = activity.signInLocation?.name {
            debugPrint(locName)
            lbLocation.text = locName
        }
       
    }
    
    @IBAction func btnClickRefreshWifi(sender: AnyObject) {
        showHud()
         let info = WifiHelper.sharedHelper().getWifiInfo()
         hideHud()
        if info == nil {
            WLAlert.alertSorry(message: "未检查到wifi信息", inViewController: self)
            return
        }
       
        if let ssid = info[K_SSID] {
            WLAlert.confirmOrCancel(title: "提示", message: "是否将wifi \(ssid) 作为签到wifi", confirmTitle: "确定", cancelTitle: "取消", inViewController: self, withConfirmAction: {[weak self] in
                let configure = SignInConfigure()
                configure.activityId = self?.activity.activityId
                configure.BSSID = info[K_BSSID] as! String
                configure.SSID = info[K_SSID] as! String
                configure.SSIDDATA = info[K_SSIDDATA] as! NSData
                self?.showHud()
                configure.saveInBackgroundWithBlock({ (succeed, error) in
                    self?.hideHud()
                    self?.activity.signInConfigure = configure
                    self?.activity.wifiEnable = true
                    self?.fdWifiSSD.text = info[K_SSID] as? String
                })
                
            }) {
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController
        if let vc = vc as? ChoseLocationViewController {
            vc.activity = activity
            vc.didChangeLocation = {[weak self] in
                self?.lbLocation.text = $0
            }
        }
    }
}

extension ChoseWifiViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
