//
//  ActivityListViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/12.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class ActivityListViewController: UITableViewController {
    var company: Company!
    var activities: [Activity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData() {
        let query = company.activities?.query()
        query?.cachePolicy = .CacheThenNetwork
        showHud()
        query?.findObjectsInBackgroundWithBlock({[weak self] (activities, error) in
            self?.hideHud()
            if let activities = activities as? [Activity] {
                self?.activities = activities
                self?.tableView.reloadData()
            }
        })
    }
}

extension ActivityListViewController {
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityListCell", forIndexPath: indexPath) as! ActivityListCell
        cell.activity = activities[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
}
