//
//  Member.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/18.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import ObjectMapper
import DifferenceKit

struct Member: Mappable, Equatable {

    var `_` : Int?
    var backImg: AnyObject?
    var backImgId: String?
    var createdAt: Int?
    var domain: String?
    var email: String?
    var headImg: HeadImg?
    var headImgId: String?
    var highlight: AnyObject?
    var inType: Int?
    var isActive: Int?
    var isCreator: Int?
    var isManage: Int?
    var joinStatus: Int?
    var name: String?
    var outUid: String?
    var updatedAt: Int?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        `_` <- map["_"]
        backImg <- map["back_img"]
        backImgId <- map["back_img_id"]
        createdAt <- map["created_at"]
        domain <- map["domain"]
        email <- map["email"]
        headImg <- map["head_img"]
        headImgId <- map["head_img_id"]
        highlight <- map["highlight"]
        inType <- map["in_type"]
        isActive <- map["is_active"]
        isCreator <- map["is_creator"]
        isManage <- map["is_manage"]
        joinStatus <- map["join_status"]
        name <- map["name"]
        outUid <- map["out_uid"]
        updatedAt <- map["updated_at"]
    }

    static func == (lhs: Member, rhs: Member) -> Bool {
        return lhs.outUid == rhs.outUid
    }
    

}

extension Member: Differentiable {

    typealias DifferenceIdentifier = String?

    var differenceIdentifier: String? {
        return outUid
    }
}
