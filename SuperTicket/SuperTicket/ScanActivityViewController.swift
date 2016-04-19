//
//  ScanActivityViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/16.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class ScanActivityViewController: UITableViewController {
    var activity: Activity!
    
    @IBOutlet weak var lbActTitle: UILabel!
    @IBOutlet weak var lbGpsEnable: UILabel!
    @IBOutlet weak var lbHttpEnable: UILabel!
    @IBOutlet weak var lbWifiEnable: UILabel!
    
    @IBOutlet weak var lbSignupTimeSetion: UILabel!
    @IBOutlet weak var lbHasSignupCount: UILabel!
    @IBOutlet weak var lbIntroduce: UILabel!
    
    @IBOutlet weak var btnAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func btnClickSignup(sender: AnyObject) {
        activity.fetchWhenSave = true
        activity.incrementKey("signupCount", byAmount: 1)
        let query = SigninupActivity.query()
        query.whereKey(k_userId, equalTo: AVUser.currentUser().objectId)
        query.getFirstObjectInBackgroundWithBlock {[weak self] (obj, error) in
            if error == nil {
                if let obj = obj as? SigninupActivity {
                    debugPrint(obj)
                    if let activityId = self?.activity.activityId {
                        obj.addObject("\(activityId)", forKey: k_SignInActivities)
                        obj.saveInBackground()
                    }
                    
                }
                
            }
        }
        showHud()
        activity.saveInBackgroundWithBlock {[weak self] (succeed, error) in
            self?.hideHud()
            if succeed {
                WLAlert.alertOk(message: "报名成功", inViewController: self!)
                self?.btnAction.setTitle("已报名", forState: .Normal)
                self?.btnAction.enabled = false
                self?.lbHasSignupCount.text = "已报名人数:\(self!.activity.signupCount.integerValue + 1)人"
            } else {
                WLAlert.alertSorry(message: "报名失败", inViewController: self!)
            }
        }
    }
    
    private func configureUI() {
        debugPrint(activity)
        title = activity.nick
        lbActTitle.text = activity.nick
        if let gpsEnable = activity.gpsEnable {
            if gpsEnable.boolValue {
                lbGpsEnable.backgroundColor = UIColor.themeColor()
            } else {
                lbGpsEnable.backgroundColor = UIColor.lightGrayColor()
            }
        } else {
            lbGpsEnable.backgroundColor = UIColor.lightGrayColor()
        }
        if let wifiEnable = activity.wifiEnable {
            if wifiEnable.boolValue {
                lbWifiEnable.backgroundColor = UIColor.themeColor()
            } else {
                lbWifiEnable.backgroundColor = UIColor.lightGrayColor()
            }
        } else {
            lbWifiEnable.backgroundColor = UIColor.lightGrayColor()
        }
        if let httpEnable = activity.httpEnable {
            if httpEnable.boolValue {
                lbHttpEnable.backgroundColor = UIColor.themeColor()
            } else {
                lbHttpEnable.backgroundColor = UIColor.lightGrayColor()
            }
        } else {
            lbHttpEnable.backgroundColor = UIColor.lightGrayColor()
        }
        
        debugPrint(activity)
        let object = activity.objectForKey("signInTime") as! [SignInTimeSection]
        debugPrint(object)
        let firstSectionId = object.first!.objectId
        let query = SignInTimeSection.query()
        showHud()
        query.getObjectInBackgroundWithId(firstSectionId) {[weak self] (section, error) in
            self?.hideHud()
            if error != nil {                print(error)
            }
            if let section = section as? SignInTimeSection {
                if error == nil {
                    self?.lbSignupTimeSetion.text = "\(section.startTime.stringWithFormat("HH:mm"))-\(section.endTime.stringWithFormat("HH:mm"))等"
                } else {
                    self?.lbSignupTimeSetion.text = ""
                }
            }
            
        }
//        if let timeSections = activity.objectForKey("signInTime") as? [SignInTimeSection] {
//            let section = timeSections.first!
//            lbSignupTimeSetion.text = "\(section.startTime.stringWithFormat("HH:mm"))-\(section.endTime.stringWithFormat("HH:mm"))等"
//        } else {
//            lbSignupTimeSetion.text = ""
//        }
        if let signupCount = activity.signupCount {
            lbHasSignupCount.text = "已报名人数:\(signupCount)人"
        } else {
            lbHasSignupCount.text = "还没有人报名"
        }
        if let introduce = activity.introduce {
            lbIntroduce.text = introduce
        } else {
            lbIntroduce.text = "暂无活动说明"
        }
        
        print(activity)
        if let activityId = activity.activityId {
             let signInQuery1 = SigninupActivity.query()
            signInQuery1.whereKey(k_SignupInActivites, containsAllObjectsInArray: ["\(activityId)"])
            
            let signInQuery2 = SigninupActivity.query()
            signInQuery2.whereKey(k_userId, equalTo: AVUser.currentUser().objectId)
            
            let compainQuery = AVQuery.andQueryWithSubqueries([signInQuery1, signInQuery2])
            showHud()
            compainQuery.getFirstObjectInBackgroundWithBlock({[weak self] (obj, error) in
                self?.hideHud()
                if error == nil {
                    self?.btnAction.setTitle("已报名", forState: .Normal)
                    self?.btnAction.enabled = false
                }
            })
        }
        
    }
}

extension ScanActivityViewController
{
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

