//
//  QZActivityExplainController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/19.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class ActivityExplainController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var activity: Activity!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    
    private func configureUI() {
        if let introduce = activity.introduce {
            textView.text = activity.introduce
        } else {
            textView.text = "还没有活动介绍"
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
                self!.activity.introduce = self!.textView.text
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
