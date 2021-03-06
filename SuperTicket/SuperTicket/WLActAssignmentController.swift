//
//  WLActAssignmentController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class WLActAssignmentController: UIViewController {
    var activity: Activity!
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if textView == nil {
            textView = UITextView()
        }
        configureUI()
    }
    
    private func configureUI() {
        if let assignment = activity.assignment {
            textView.text = activity.assignment
        } else {
            textView.text = "还没有活动任务"
        }
        
        if activity.publisherId != AVUser.currentUser().objectId {
            textView.userInteractionEnabled = false
        } else {
            navigationItem.rightBarButtonItem = TitleBarButtonItem(title: "修改", tap: {[weak self] in
                if self == nil {
                    return
                }
                if self!.textView.text.isEmpty {
                    return
                }
                self!.activity.assignment = self!.textView.text
                self!.showHud()
                self!.activity.saveInBackgroundWithBlock({ (succeed, error) in
                    self!.hideHud()
                    if succeed {
                        WLAlert.alertOk(message: "保存成功", inViewController: self!)
                    } else {
                        WLAlert.alertSorry(message: "保存失败", inViewController: self!)
                    }
                })
                })
        }
       
    }
    
}


