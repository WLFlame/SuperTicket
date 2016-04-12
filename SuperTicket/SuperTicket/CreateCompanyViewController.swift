//
//  CreateCompanyViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/11.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import ImagePicker

enum CompanyVcType {
    case Update, Create
}

class CreateCompanyViewController: UITableViewController {
    var company: Company?
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var fdNick: UITextField!
    @IBOutlet weak var fdIntroduce: UITextField!
    @IBOutlet weak var fdTel: UITextField!
    @IBOutlet weak var fdEmail: UITextField!
    @IBOutlet weak var fdCompanyCategory: UITextField!
    @IBOutlet weak var fdAddr: UITextField!
    // 头像是否改变
    var avatarIsChange: Bool = false
    
    var vcType: CompanyVcType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if company != nil {
            vcType = .Update
            title = "修改公司信息"
            configureData()
        } else {
            vcType = .Create
            title = "添加公司信息"
        }
        setupUI()
    }
    
    private func configureData() {
        if let avatar = company?.avatar {
            imgAvatar.kf_setImageWithURL(NSURL(string: avatar.url)!)
        }
        fdNick.text = company?.nick
        fdIntroduce.text = company?.introduce
        fdTel.text = company?.tel
        fdEmail.text = company?.email
        fdCompanyCategory.text = company?.category
        fdAddr.text = company?.address
        
        
    }
    
    private func setupUI() {
        imgAvatar.layer.cornerRadius = 27.5
        imgAvatar.layer.masksToBounds = true
        imgAvatar.userInteractionEnabled = true
        
        imgAvatar.addTapGestureRecognizer {[weak self] (tap, gestureId) in
            WLLinkUtil.sharedInstance.linkToChoseAvatarVc(self!)
        }
        navigationItem.rightBarButtonItem = TitleBarButtonItem(title: "确定", tap: {[weak self] in
            guard let mine = self else {
                return
            }
            if mine.vcType == .Update {
                mine.updateCompany()
            } else {
                mine.createCompany()
            }
        })
    }
    
    private func updateCompany() {
        company?.nick = fdNick.text
        company?.introduce = fdIntroduce.text
        company?.tel = fdTel.text
        company?.email = fdEmail.text
        company?.category = fdCompanyCategory.text
        company?.address = fdAddr.text
        if avatarIsChange {
             if let avatar = imgAvatar.image {
                let avatar = AVFile(data: UIImagePNGRepresentation( UIImage.resizeAvatarImage(avatar)))
                company?.avatar = avatar
            }
        }
        showHud()
        company?.saveInBackgroundWithBlock({[weak self] (succeed, error) in
            self?.hideHud()
            WLAlert.alertOk(message: !succeed ? "保存失败" : "保存成功" , inViewController: self)
            NSNotificationCenter.defaultCenter().postNotificationName(WLConfig.Notification.CompanyDataDidChangeNotification, object: [k_NotificationChangeType : WLConfig.NotificationChangeType.Update.rawValue, k_Company : self!.company!])
        })
    }
    
    
    
    private func createCompany() {
        if bindFields(fdNick, fdIntroduce, fdTel, fdCompanyCategory, fdTel) {
            let company = Company()
            company.nick = fdNick.text
            company.introduce = fdIntroduce.text
            if let avatar = imgAvatar.image {
                let avatar = AVFile(data: UIImagePNGRepresentation( UIImage.resizeAvatarImage(avatar)))
                company.avatar = avatar
            }
            company.tel = fdTel.text
            company.email = fdEmail.text
            company.category = fdCompanyCategory.text
            company.address = fdAddr.text
            showHud()
            company.saveInBackgroundWithBlock({[weak self] (succeed, error) in
                self?.hideHud()
                WLAlert.alertOk(message: !succeed ? "保存失败" : "保存成功" , inViewController: self)
                NSNotificationCenter.defaultCenter().postNotificationName(WLConfig.Notification.CompanyDataDidChangeNotification, object: [k_NotificationChangeType : WLConfig.NotificationChangeType.Add.rawValue, k_Company : company])
            })
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

extension CreateCompanyViewController: ImagePickerDelegate {
    func wrapperDidPress(images: [UIImage]) {
        WLLinkUtil.sharedInstance.dismissAvatarVc()
        imgAvatar.image = images.first
        avatarIsChange = true
    }
    
    func doneButtonDidPress(images: [UIImage]) {
        WLLinkUtil.sharedInstance.dismissAvatarVc()
        imgAvatar.image = images.first
        avatarIsChange = true
    }
    
    func cancelButtonDidPress() {
         WLLinkUtil.sharedInstance.dismissAvatarVc()
    }
    
}

