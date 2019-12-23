//
//  AppState.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/23.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import ReSwift
import ReSwiftThunk

let thunksMiddleware: Middleware<AppState> = createThunkMiddleware()
let appStore = Store<AppState>(reducer: qppReducer, state: nil, middleware: [thunksMiddleware])

struct AppState: StateType {
    var members: MembersState
}
