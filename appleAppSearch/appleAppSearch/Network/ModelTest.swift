//
//  ModelTest.swift
//  appleAppSearch
//
//  Created by hyunjun yang on 04/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import Foundation
import Moya

public enum Marvel {
    static private let publicKey = "testPublicKey"
    static private let privateKey = "testPrivateKey"
    
    case comics
    
}

extension Marvel : TargetType  {
    public var baseURL: URL {
        <#code#>
    }
    
    public var path: String {
        <#code#>
    }
    
    public var method: Moya.Method {
        <#code#>
    }
    
    public var sampleData: Data {
        <#code#>
    }
    
    public var task: Task {
        <#code#>
    }
    
    public var headers: [String : String]? {
        <#code#>
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
