//
//  ActivityViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/12.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class ActivityViewController: UITableViewController {

    @IBOutlet weak var fdActName: UITextField!
    @IBOutlet weak var fdStartTimeField: UITextField!
    @IBOutlet weak var fdEndTimeField: UITextField!
    @IBOutlet weak var lbGps: UILabel!
    @IBOutlet weak var lbWifi: UILabel!
    @IBOutlet weak var introduceTextView: QZPlaceholderTextView!
    var company: Company!
    var isChoseHttp: Bool = false
    @IBOutlet weak var lbHttp: UILabel!
    var activity: Activity!
    var startDate: NSDate?
    var endDate: NSDate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        activity = Activity()
        
    }
    
   
    
    private func configureUI() {
        introduceTextView.myPlaceholder = "介绍一下此次活动"
        introduceTextView.font = UIFont.systemFontOfSize(13)
        
        let datePicker = UIDatePicker()
        fdStartTimeField.inputView = datePicker
        let completeView = NSBundle.mainBundle().loadNibNamed("CompleteView", owner: nil, options: nil).last as! CompleteView
        completeView.completeBlock = { [weak self] in
            self?.fdStartTimeField.resignFirstResponder()
            self?.fdStartTimeField.text = datePicker.date.formatWithLocalTimeZone()
            self?.startDate = datePicker.date
        }
        fdStartTimeField.inputAccessoryView = completeView
       
        let datePicker2 = UIDatePicker()
        fdEndTimeField.inputView = datePicker2
        let completeView2 = NSBundle.mainBundle().loadNibNamed("CompleteView", owner: nil, options: nil).last as! CompleteView
        completeView2.completeBlock = { [weak self] in
            self?.fdEndTimeField.resignFirstResponder()
            self?.fdEndTimeField.text = datePicker2.date.formatWithLocalTimeZone()
            self?.endDate = datePicker2.date
        }
        fdEndTimeField.inputAccessoryView = completeView2
        
        lbHttp.userInteractionEnabled = true
        lbHttp.addTapGestureRecognizer { [weak self] (tap, gestureId) in
            self!.isChoseHttp = !self!.isChoseHttp
            self!.lbHttp.backgroundColor = self!.isChoseHttp ? UIColor.themeColor() : UIColor.lightGrayColor()
            self!.activity.httpEnable = self!.isChoseHttp
        }
        
        
    }

    @IBAction func endSignupAction(sender: AnyObject) {
        if !bindFields(fdActName, fdStartTimeField, fdEndTimeField) {
            return
        }
        
        activity.nick = fdActName.text
        activity.startTimeDate = startDate
        activity.endTimeDate = endDate
        activity.introduce = introduceTextView.text
        if let wifiEnable = activity.wifiEnable {
            if !wifiEnable.boolValue {
                WLAlert.alertSorry(message: "请选择一种签到方式", inViewController: self)
                return
            }
        } else if let httpEnable = activity.httpEnable {
            if !httpEnable.boolValue {
                WLAlert.alertSorry(message: "请选择一种签到方式", inViewController: self)
                return
            }
        } else if let gpsEnable = activity.gpsEnable {
            if !gpsEnable.boolValue {
                WLAlert.alertSorry(message: "请选择一种签到方式", inViewController: self)
                return
            }
        } else {
            WLAlert.alertSorry(message: "请选择一种签到方式", inViewController: self)
            return
        }
       
      
        if activity.objectForKey("signInTime") == nil {
            WLAlert.alertSorry(message: "请选择签到时段", inViewController: self)
            return
        }
        
        activity.companyId = company.companyId
        debugPrint(company.companyId)
        showHud()
        
        activity.saveInBackgroundWithBlock {[weak self] (succeed, error) in
            self?.hideHud()
            if succeed {
                self?.navigationController?.popViewControllerAnimated(true)
            } else {
                WLAlert.alertSorry(message: "保存失败", inViewController: self!)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVc = segue.destinationViewController
        if let vc = destinationVc as? ChoseWifiViewController {
            vc.activity = activity
        } else if let vc = destinationVc as? ChoseTimeSectionController {
            vc.activity = activity
        }
    }

}



extension ActivityViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}