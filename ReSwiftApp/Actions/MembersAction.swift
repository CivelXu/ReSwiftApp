//
//  MainStateAction.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/18.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import ReSwift

enum MainStateAction: Action {
    case addMembers(members: [Member], append: Bool)
    case requestMemberError(error: Error, append: Bool)
    case didSelectRow(Int)
    case beginFooterRefresh
}
