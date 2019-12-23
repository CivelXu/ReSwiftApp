//
//  MembersReducer.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/23.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import ReSwift

func membersReducer(action: Action, state: MembersState?) -> MembersState {
    var state = state ?? MembersState()
    guard let action = action as? MembersAction else {
        return state
    }

    switch action {
    case .loadingShow:
        state.loadingState = .loading
    case .loadingDismiss:
        state.loadingState = .success
    case .addMembers(let members, let append):
        state.loadingState = .success
        if !append {
            state.currentPage = 0
            state.members.removeAll()
            state.headerState = .end
        } else {
            state.footerState = .end
        }
        state.members.append(contentsOf: members)
        if members.count < 20 {
            state.footerState = .noMoreData
        }
        state.currentPage += 1
    case .requestMemberError(let error, let append):
        state.loadingState = .error(error)
        if !append {
            state.headerState = .end
        } else {
            state.footerState = .end
        }
    case .didSelectMember(let member):
        state.selectMember = member
    case .cancelSelect:
        state.selectMember = nil
    case .beginFooterRefresh:
        state.footerState = .refresing
    case .resetFooterRefresh:
        state.footerState = .resetNoMoreData
    }
    return state
}
