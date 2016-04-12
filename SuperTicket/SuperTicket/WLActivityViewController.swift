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
        registerNotification()
        tableView.mj_header.beginRefreshing()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func registerNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(WLActivityViewController.companyDataDidChange(_:)), name: WLConfig.Notification.CompanyDataDidChangeNotification, object: nil)
    }
    
    @objc private func companyDataDidChange(notificaiton: NSNotification) {
        guard let obj = notificaiton.object as? [String : AnyObject] else {
            return
        }
        let company = obj[k_Company] as! Company
        
        
        switch obj[k_NotificationChangeType]! as! String {
        case WLConfig.NotificationChangeType.Update.rawValue:
            companies.removeAtIndex(companies.indexOf(company)!)
            companies.append(company)
            tableView.reloadData()
        case WLConfig.NotificationChangeType.Add.rawValue:
            companies.insert(company, atIndex: 0)
            tableView.reloadData()
        case WLConfig.NotificationChangeType.Remove.rawValue:
            companies.removeAtIndex(companies.indexOf(company)!)
            tableView.reloadData()
            
        default:
            break
        }
       
    }
    
    private func configureUI() {
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
        query.cachePolicy = .CacheThenNetwork
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.deselectRowAtIndexPath(indexPath, animated: true)
        WLLinkUtil.sharedInstance.linkToCompanyDetailVc(self, company: self.companies[indexPath.row])
    }

}

extension WLActivityViewController {
}


