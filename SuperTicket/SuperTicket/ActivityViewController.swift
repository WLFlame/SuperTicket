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
    @IBOutlet weak var lbSignupCount: UILabel!
    @IBOutlet weak var lbActIntroduce: UILabel!
    @IBOutlet weak var fdStartTimeField: UITextField!
    @IBOutlet weak var fdEndTimeField: UITextField!
    @IBOutlet weak var lbGps: UILabel!
    @IBOutlet weak var lbWifi: UILabel!
    var company: Company!
    @IBOutlet weak var lbHttp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        func configurePicker(fd: UITextField ) {
            let datePicker = UIDatePicker()
            fd.inputView = datePicker
            let completeView = NSBundle.mainBundle().loadNibNamed("CompleteView", owner: nil, options: nil).last as! CompleteView
            completeView.completeBlock = {
                fd.resignFirstResponder()
            }
            fd.inputAccessoryView = completeView
        }
       
        
        configurePicker(fdStartTimeField)
        configurePicker(fdEndTimeField)
        
    }

    @IBAction func endSignupAction(sender: AnyObject) {
    }

}

extension ActivityViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}