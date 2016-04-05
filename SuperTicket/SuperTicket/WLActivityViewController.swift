//
//  WLActivityViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class WLActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension WLActivityViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension WLActivityViewController : UITableViewDelegate {

}
