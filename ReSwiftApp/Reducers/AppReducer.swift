//
//  AppReducer.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/23.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import ReSwift

func qppReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        members: membersReducer(action: action, state: state?.members)
    )
}
