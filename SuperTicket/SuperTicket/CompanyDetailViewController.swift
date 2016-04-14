//
//  CompanyDetailViewController.swift
//  SuperTicket
//
//  Created by ywl on 16/4/12.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import Kingfisher

class CompanyDetailViewController: UITableViewController {
    
    var company: Company!

    @IBOutlet weak var lbNick: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbIntroduce: UILabel!
    @IBOutlet weak var lbTel: UILabel!
    @IBOutlet weak var lbAddr: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbCode: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureUI()
    }
    
    private func configureUI() {
        imgAvatar.layer.cornerRadius = 27.5
        imgAvatar.layer.masksToBounds = true
        navigationItem.rightBarButtonItem = TitleBarButtonItem(title: "修改", tap: { [weak self] in
            WLLinkUtil.sharedInstance.linkToCreateOrUpdateCompanyVc(self!, company: self?.company)
        })
    }
    
    private func configureData() {
        title = company.nick
        lbNick.text = company.nick
        if let avatar = company.avatar {
             imgAvatar.kf_setImageWithURL(NSURL(string: avatar.url)!)
        }
        lbIntroduce.text = company.introduce
        lbTel.text = company.tel
        lbAddr.text = company.address
        lbCategory.text = company.category
        lbEmail.text = company.email
        lbCode.text = String(company.companyId)
    }

}

extension CompanyDetailViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 2 {
            WLLinkUtil.sharedInstance.linkToActivityListVc(self, company: company)
        }
       
    }
}
