//
//  QZRegisterViewController.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/7.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class QZRegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgAvatarView: UIImageView!
    @IBOutlet weak var fieldNickName: UITextField!
    @IBOutlet weak var fieldSelfIntro: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.title = "注册"
    }
    
    private func configureUI() {
        imgAvatarView.layer.cornerRadius = 50
        imgAvatarView.layer.masksToBounds = true
        imgAvatarView.userInteractionEnabled = true
        imgAvatarView.backgroundColor = UIColor.flatGrayColor()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(QZRegisterViewController.presentImagePickerSheet(_:)))
        imgAvatarView.addGestureRecognizer(tapRecognizer)
    }
    
    func presentImagePickerSheet(gestureRecognizer: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.allowsEditing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imgAvatarView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnClickSure(sender: AnyObject) {
        if fieldNickName.text!.isEmpty {
            WLAlert.alertSorry(message: "请输入昵称", inViewController: self)
            return
        }
        
        if fieldNickName.text!.isEmpty {
            WLAlert.alertSorry(message: "请输入密码", inViewController: self)
            return
        }
        
        let user = AVUser()
        user.username = fieldNickName.text
        user.password = fieldSelfIntro.text
        if let image = imgAvatarView.image {
            let avatardata = UIImagePNGRepresentation(image)
            let file = AVFile(name: "avatar", data: avatardata!)
            file .saveInBackgroundWithBlock({ (succeed, error) in
                user .setObject(file.url, forKey: "avatar")
                user.signUpInBackgroundWithBlock({[weak self] (succeed, error) in
                    if succeed {
                        dispatch_async(dispatch_get_main_queue(), {
                            WLAlert.alertOk(message: "注册成功", inViewController: self)
                             WLLinkUtil.sharedInstance.linkToLoginVc(.None)
                        })
                       
                    }
                })
            })
        }
        
        
    }
   
    
}
