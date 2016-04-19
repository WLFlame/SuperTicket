//
//  QZSignupViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class WLSignupViewController: UIViewController {

    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbSubTime: UILabel!
    @IBOutlet weak var activityChoicePicker: UIPickerView!
    var timer: NSTimer!
    var activities: [Activity] = []
    var seletedRow = 0
    
    var seleteActivity: Activity? {
        get {
            if self.activities.count > 0 {
                return self.activities[seletedRow]
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        fetchData()
    }
    
    private func fetchData() {
        let query = SigninupActivity.query()
        query.whereKey(k_userId, equalTo: AVUser.currentUser().objectId)
        query.getFirstObjectInBackgroundWithBlock {[weak self] (obj, error) in
            if error == nil {
                if let obj = obj as? SigninupActivity {
                    debugPrint(obj.signInActivities)
                    self?.fetchActivityData(obj)
                }
            }
        }
    }
    
    private func fetchActivityData(object: SigninupActivity) {
        for actId in object.signInActivities {
            let query = Activity.query()
            query.whereKey("activityId", equalTo: (actId as NSString).integerValue)
            query.getFirstObjectInBackgroundWithBlock({[weak self] (obj, error) in
                if error == nil {
                    if let obj = obj as? Activity {
                        debugPrint(obj)
                        self?.activities.append(obj)
                        self?.activityChoicePicker.reloadComponent(0)

                    }
                }
            })
        }
    }
    
    private func setupUI() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(WLSignupViewController.timeStart), userInfo: nil, repeats: true)
        lbTime.text = NSDate().stringWithFormat("hh:mm ss")
    }
    
    func timeStart() {
        lbTime.text = NSDate().stringWithFormat("hh:mm ss")
    }
    
}

// MARK: - Action Method
extension WLSignupViewController {
    // 活动说明
    @IBAction func actSummary(sender: AnyObject) {
        let explainVc = ActivityExplainController.createFromStoryBoard(StoryBoardName.Signup.rawValue, vcStroreId: "ActivityExplainController") as! ActivityExplainController
        explainVc.activity = seleteActivity
        navigationController?.pushViewController(explainVc, animated: true)
    }
    
    // 签到情况
    @IBAction func signupState(sender: AnyObject) {
        let stateVc = WLSignupStateController()
        navigationController?.pushViewController(stateVc, animated: true)
    }
    
    // 本次活动任务
    @IBAction func actAssignment(sender: AnyObject) {
        let assignmentVc = WLActAssignmentController.createFromStoryBoard(StoryBoardName.Signup.rawValue, vcStroreId: "WLActAssignmentController") as! WLActAssignmentController
        assignmentVc.activity = seleteActivity
        navigationController?.pushViewController(assignmentVc, animated: true)
    }
    
    // 提交电子票
    @IBAction func submitTicket(sender: AnyObject) {
        
    }

    // 活动聊天室
    @IBAction func actChatRoom(sender: AnyObject) {
        
    }
}

// MARK: - UIPickerViewDataSource
extension WLSignupViewController : UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.activities.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let act = self.activities[row]
        return act.nick
    }
}

// MARK: - UIPickerViewDelegate
extension WLSignupViewController : UIPickerViewDelegate {

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        seletedRow = row
    }
}



