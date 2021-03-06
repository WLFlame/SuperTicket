//
//  ActivityListCell.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/12.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

class ActivityListCell: UITableViewCell {

    @IBOutlet weak var lbTimeSection: UILabel!
    @IBOutlet weak var lbActTitle: UILabel!
    var activity: Activity! {
        didSet {
            lbActTitle.text = activity.nick
            
            lbTimeSection.text = "\(activity.startTimeDate!.stringWithFormat("yyyy/MM/dd HH:mm"))-\(activity.endTimeDate!.stringWithFormat("yyyy/MM/dd HH:mm"))"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbTimeSection.font = UIFont.systemFontOfSize(12)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    

}
