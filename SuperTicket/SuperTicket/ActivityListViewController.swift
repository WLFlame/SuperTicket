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
        configureUI()
        
        fetchData()
    }
    
    private func configureUI() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        navigationItem.rightBarButtonItem = ImageBarButtonItem(image: UIImage(named: "add")!, tap: {[weak self] in
            WLLinkUtil.sharedInstance.linkToCreateActivityVc(self!, company: self!.company)
        })
    }
    
    private func fetchData() {
//        let query = company.activities?.query()
//        query?.cachePolicy = .CacheThenNetwork
//        showHud()
//        query?.findObjectsInBackgroundWithBlock({[weak self] (activities, error) in
//            self?.hideHud()
//            if let activities = activities as? [Activity] {
//                if activities.count > 0 {
//                    self?.activities = activities
//                    self?.tableView.reloadData()
//                } else {
//                    self?.tableView.reloadEmptyDataSet()
//                }
//                
//            } else {
//                self?.tableView.reloadEmptyDataSet()
//            }
//        })
        let query = Activity.query()
        showHud()
        query.whereKey("companyId", equalTo: company.companyId)
        query.findObjectsInBackgroundWithBlock {[weak self] (activies, error) in
            self?.hideHud()
            if let activities = activies as? [Activity] {
                if activities.count > 0 {
                    self?.activities = activities
                    self?.tableView.reloadData()
                } else {
                    self?.tableView.reloadEmptyDataSet()
                }

            } else {
                self?.tableView.reloadEmptyDataSet()
            }
        }
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        WLLinkUtil.sharedInstance.linkToScanActivityVc(self, activity: activities[indexPath.row])
    }
}




