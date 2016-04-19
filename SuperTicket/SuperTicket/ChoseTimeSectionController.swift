//
//  ChoseTimeSectionController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/14.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class ChoseTimeSectionController: UITableViewController {
    var activity: Activity!
    @IBOutlet weak var fdTimeSectionSummary: UITextField!
    @IBOutlet weak var fdStartTime: UITextField!
    @IBOutlet weak var fdEndTime: UITextField!
    var startTime: NSDate?
    var endTime: NSDate?

    @IBAction func btnClickCommit(sender: AnyObject) {
        if !bindFields(fdTimeSectionSummary, fdStartTime, fdEndTime) {
            return
        }
        
        if endTime!.compare(startTime!) == .OrderedDescending {
            let signInTime = SignInTimeSection()
            signInTime.activityId = activity.activityId
            signInTime.name = fdTimeSectionSummary.text
            signInTime.startTime = startTime
            signInTime.endTime = endTime
            signInTime.saveInBackgroundWithBlock({ (succeed, error) in
                if succeed {
                     self.activity.addObject(signInTime, forKey: "signInTime")
                    self.navigationController?.popViewControllerAnimated(true)
                }
            })
//            if activity.signInTimeSections == nil {
//                activity.signInTimeSections = []
//                 activity.signInTimeSections.append(signInTime)
//            } else {
//               activity.signInTimeSections.append(signInTime)
//            }
           
            
        } else {
            WLAlert.alertSorry(message: "结束时间必须在开始时间之后", inViewController: self)
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .Time
        fdStartTime.inputView = datePicker
        let completeView = NSBundle.mainBundle().loadNibNamed("CompleteView", owner: nil, options: nil).last as! CompleteView
        completeView.completeBlock = { [weak self] in
            self?.fdStartTime.resignFirstResponder()
            self?.fdStartTime.text = datePicker.date.dateWithFormat("HH:mm")
            self?.startTime = datePicker.date
        }
        fdStartTime.inputAccessoryView = completeView
        
        let datePicker2 = UIDatePicker()
        datePicker2.datePickerMode = .Time
        fdEndTime.inputView = datePicker2
        let completeView2 = NSBundle.mainBundle().loadNibNamed("CompleteView", owner: nil, options: nil).last as! CompleteView
        completeView2.completeBlock = { [weak self] in
            self?.fdEndTime.resignFirstResponder()
            self?.fdEndTime.text = datePicker2.date.dateWithFormat("HH:mm")
            self?.endTime = datePicker2.date
        }
        fdEndTime.inputAccessoryView = completeView2
        
        

    }
}
