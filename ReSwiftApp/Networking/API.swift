//
//  API.swift
//  ReSwiftApp
//
//  Created by Civel Xu on 2019/12/18.
//  Copyright © 2019 Civel Xu. All rights reserved.
//

import Moya

private let NetWorkBaseURL = "https://iyuanben.com:30613"

enum API {
    case getMembers(page: Int)
}

extension API: TargetType {

    var baseURL: URL {
        return URL(string: NetWorkBaseURL)!
    }

    var path: String {
        switch self {
        case .getMembers(_):
            return "/v1/groups/6d732a380a18ec531781a32db8947a362d0978b2458ab8c390cc016792e3f2e8/users"
        }
    }
    
    var method: Method {
        switch self {
        case .getMembers(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return "response: test data".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .getMembers(let page):
            let parameters = ["page" : page, "page_size" : 20]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["SessionKey" : "1e0c9920de3b168ece58f298af6740e7aa609a7b493f223c5d991c0da1c0ad83",
             "OrgID" : "e9ed44003980bf0cf7c73a354af9f3870890a388f3aaad7c76d0e5d74fcb3540"]
    }
    
    
}
