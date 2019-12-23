//
//  MainState.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/18.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import ReSwift

enum LoadingStatus {
    case initial
    case loading
    case success
    case error(Error)
}

enum RefreshHeaderStatus {
    case initial
    case refresing
    case end
}

enum RefreshFooterStatus {
    case initial
    case refresing
    case end
    case noMoreData
    case resetNoMoreData
}

struct MembersState {
    var currentPage: Int = 0
    var members: [Member] = []
    var selectMember: Member?
    var loadingState: LoadingStatus = .initial
    var headerState: RefreshHeaderStatus = .initial
    var footerState: RefreshFooterStatus = .initial
}
