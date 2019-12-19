//
//  MainState.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/18.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import ReSwift
import ReSwiftThunk

let thunksMiddleware: Middleware<MainState> = createThunkMiddleware()
let mainStore = Store<MainState>(reducer: mainReducer, state: nil, middleware: [thunksMiddleware])

struct MainState: StateType {

    var currentPage: Int = 0
    var members: [Member] = []
    var error: Error?
    var selectMember: Member?

    var footerRefresh = false
    var endHeaderFresh = false
    var endFooterFresh = false
    var isNoMoreData = false

}

func mainReducer(action: Action, state: MainState?) -> MainState {

    var state = state ?? MainState()
    guard let action = action as? MainStateAction else {
        return state
    }

    /// reset store state
    state.selectMember = nil
    state.error = nil
    state.isNoMoreData = false
    state.footerRefresh = false
    state.endHeaderFresh = false
    state.endFooterFresh = false

    switch action {
    case .addMembers(let members, let append):
        if !append {
            state.currentPage = 0
            state.members.removeAll()
        } else {
        }
        state.endHeaderFresh = !append
        state.endFooterFresh = append
        state.members.append(contentsOf: members)
        state.isNoMoreData = members.count < 20
        state.currentPage += 1
    case .requestMemberError(let error, let append):
        state.error = error
        state.endHeaderFresh = !append
        state.endFooterFresh = append
    case .didSelectRow(let index):
        guard state.members.count > index else { return state }
        state.selectMember = state.members[index]
    case .beginFooterRefresh:
        state.footerRefresh = true
    }

    return state
}
