//
//  NetworkCommunication.swift
//  appleAppSearch
//
//  Created by 양현준 on 11/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import Moya

class Networking {
     let provider = MoyaProvider<SearchAppleRepo>()
    
    func AppleSearch(words term:String, completion: @escaping (SearchResponse) -> Void) {
        provider.request(.term(searchStr: term))  { result in
            switch result {
            case let .success(moyaResponse):
                log.verbose("Network Connection Success")
//                log.verbose(moyaResponse.data.base64EncodedString())
                let decoder = JSONDecoder()
                do {
                    let resultInfo = try decoder.decode(SearchResponse.self, from: moyaResponse.data)
                    log.verbose("JSON Parsing Success")
                    completion(resultInfo);
                } catch  {
                    log.error("JSON Parsing Fail")
                    log.error(error)
                }
            case let .failure(moyaError):
                //Network Fail Error
                log.error("Network Connection Error")
                log.error(moyaError)
            }
        }
    }
    
    
    
}
