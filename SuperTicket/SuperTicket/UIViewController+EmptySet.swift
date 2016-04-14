//
//  UIViewController+EmptySet.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/11.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import Foundation
import DZNEmptyDataSet

protocol ShowEmpty {
    var empty: Bool {
        get
        set
    }
}

extension UIViewController : ShowEmpty {
    var empty: Bool {
        get {
            return false
        }
        
        set {
        }
    }
}

extension UIViewController: DZNEmptyDataSetSource {
    public func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "抱歉，这里还没有数据"
        let font = UIFont.systemFontOfSize(14)
        let textColor = UIColor(hexString: "#292f33")
        let muAttri = NSMutableAttributedString(string: text, attributes: [NSFontAttributeName:font, NSForegroundColorAttributeName: textColor])
        return muAttri
    }
    
    public func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .ByWordWrapping
        paragraph.alignment = .Center
        let text = "这里还没有任何的数据，请稍后重试"
        let font = UIFont.systemFontOfSize(12)
        let textColor = UIColor(hexString: "#8899a6")
        let muAttri = NSMutableAttributedString(string: text, attributes: [NSFontAttributeName:font, NSForegroundColorAttributeName: textColor])
        return muAttri
    }

    
    public func spaceHeightForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return 10
    }

}

extension UIViewController : DZNEmptyDataSetDelegate {
    
    public func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
   
    
}