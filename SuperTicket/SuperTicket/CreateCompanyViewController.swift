//
//  CreateCompanyViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/11.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit
import ImagePicker

class CreateCompanyViewController: UITableViewController {
    var company: Company?
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var fdNick: UITextField!
    @IBOutlet weak var fdIntroduce: UITextField!
    @IBOutlet weak var fdTel: UITextField!
    @IBOutlet weak var fdEmail: UITextField!
    @IBOutlet weak var fdCompanyCategory: UITextField!
    @IBOutlet weak var fdAddr: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
            if bindFields(mine.fdNick, mine.fdIntroduce, mine.fdTel, mine.fdCompanyCategory, mine.fdTel) {
                let company = Company()
                company.nick = mine.fdNick.text
                company.introduce = mine.fdIntroduce.text
                if let avatar = mine.imgAvatar.image {
                    let avatar = AVFile(data: UIImagePNGRepresentation( UIImage.resizeAvatarImage(avatar)))
                    company.avatar = avatar
                }
                company.tel = mine.fdTel.text
                company.email = mine.fdEmail.text
                company.category = mine.fdCompanyCategory.text
                company.address = mine.fdAddr.text
                mine.showHud()
                company.saveInBackgroundWithBlock({ (succeed, error) in
                    mine.hideHud()
                    WLAlert.alertSorry(message: !succeed ? "保存失败" : "保存成功" , inViewController: mine)
                })
            }
        })
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

extension CreateCompanyViewController: ImagePickerDelegate {
    func wrapperDidPress(images: [UIImage]) {
        WLLinkUtil.sharedInstance.dismissAvatarVc()
        imgAvatar.image = images.first
    }
    
    func doneButtonDidPress(images: [UIImage]) {
        WLLinkUtil.sharedInstance.dismissAvatarVc()
        imgAvatar.image = images.first
    }
    
    func cancelButtonDidPress() {
         WLLinkUtil.sharedInstance.dismissAvatarVc()
    }
    
}

