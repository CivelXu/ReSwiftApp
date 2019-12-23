//
//  MainStateAction.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/18.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import ReSwift

enum MembersAction: Action {
    case loadingShow
    case loadingDismiss
    case addMembers(members: [Member], append: Bool)
    case requestMemberError(error: Error, append: Bool)
    case didSelectMember(Member)
    case cancelSelect
    case beginFooterRefresh
    case resetFooterRefresh
}
