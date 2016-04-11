//
//  WLActivityViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/3.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class WLActivityViewController: UITableViewController {

    var companies: [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.mj_header.beginRefreshing()
    }
    
    private func configureUI() {
        title = "活动"
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        navigationItem.rightBarButtonItem = ImageBarButtonItem(image: UIImage(named: "add")!, tap: {[weak self] in
            if self == nil { return }
            WLLinkUtil.sharedInstance.linkToCreateOrUpdateCompanyVc(self!)
        })
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            self?.fetchData()
        })
    }
    
    
    private func fetchData() {
        let query = AVQuery(className: k_Company)
        query.findObjectsInBackgroundWithBlock {[weak self] (companies, error) in
            
            if error != nil {
                asyncInMain({ 
                    self?.tableView.reloadEmptyDataSet()
                    self?.tableView.mj_header.endRefreshing()
                })
                return
            }
            if let companies = companies as? [Company] {
                self?.companies = companies
                asyncInMain({ 
                     self?.tableView.reloadData()
                    self?.tableView.mj_header.endRefreshing()
                })
            }
           
        }
    }

}

extension WLActivityViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ActivityCellIden"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
           cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = companies[indexPath.row].nick
        return cell!
    }

}

extension WLActivityViewController {
}


