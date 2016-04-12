//
//  Company.swift
//  SuperTicket
//
//  Created by wanli.yang on 16/4/10.
//  Copyright © 2016年 wanli.yang. All rights reserved.
//

import UIKit

let k_Company_IncreamentKey = "companyId"

class Company: AVObject, AVSubclassing {
    @NSManaged var companyId: NSNumber!
    @NSManaged var nick: String!
    @NSManaged var avatar: AVFile?
    @NSManaged var introduce: String?
    @NSManaged var tel: String?
    @NSManaged var address: String?
    @NSManaged var category: String?
    @NSManaged var email: String?
    @NSManaged var activities: AVRelation?
    static func parseClassName() -> String! {
        return "Company";
    }

}

func ==(lhs: Company, rhs: Company) -> Bool {
    return lhs.companyId == rhs.companyId
}
