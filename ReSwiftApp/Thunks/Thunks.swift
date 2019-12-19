//
//  Thunks.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/18.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import ReSwift
import ReSwiftThunk

let fetchNewMembers = Thunk<MainState> { dispatch, getState in
    guard var state = getState() else { return }
    fetchNetwork(page: 0, append: false, dispatch: dispatch)
}

let fetchNextPageMembers = Thunk<MainState> { dispatch, getState in
    guard let state = getState() else { return }
    let page = state.currentPage
    fetchNetwork(page: page, append: true, dispatch: dispatch)
}

fileprivate func fetchNetwork(page: Int, append: Bool, dispatch: @escaping DispatchFunction) {
    API.getMembers(page: page).requestArray(
        model: Member.self,
        success: { models in
            dispatch(MainStateAction.addMembers(members: models, append: append))
    }) { (error) in
        dispatch(MainStateAction.requestMemberError(error: error, append: append))
    }
}
