//
//  ModelTest.swift
//  appleAppSearch
//
//  Created by hyunjun yang on 04/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import Foundation
import Moya

public enum SearchAppleRepo {
    
    case term(searchStr : String)
    
    private static let country = "ko"
    private static let media = "software"
    private static let limitDataList = 20
}

extension SearchAppleRepo : TargetType  {
    public var baseURL: URL {
        return URL(string: "https://itunes.apple.com/search?")!
    }
    
    public var path: String {
        switch self {
        case .term(let searchStr):
            return "term=\(searchStr)"
        }
    }
    
    public var method: Moya.Method {
       return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestParameters(parameters:
            [
                "term":"test",
                "country":SearchAppleRepo.country,
                "media":SearchAppleRepo.media,
                "limit":String(describing:SearchAppleRepo.limitDataList)
            ] ,encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
