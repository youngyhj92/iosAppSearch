//
//  ViewController.swift
//  appleAppSearch
//
//  Created by hyunjun yang on 03/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import Moya

class SearchViewController: UIViewController {

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let searchApp = SearchAppleRepo.term(searchStr: "test")
        
         let provider = MoyaProvider<SearchAppleRepo>()
        provider.request(.term(searchStr: "Wrapsody"))  {  result in
            switch result {
            case let .success(moyaResponse):
                print(moyaResponse.request)
                print("성공")
                print(moyaResponse.description)
                print("Check")
                
                guard let appInformation = try? JSONDecoder().decode(SearchResponse.self, from: moyaResponse.data) else {
                    print("failed")
                    return
                }
                
                print(appInformation.resultCount)
//                let decoder = JSONDecoder()
//                if let appInformation = try? decoder.decode(SearchResponse.self, from: moyaResponse.data)  {
//                    print("Success")
//                    print(appInformation.resultCount)
//                } else {
//                    print("Fail")
//                }
//                self.jsonDecode(jsonData: moyaResponse.data)
//                print(moyaResponse.data.base64EncodedString())
                print("check")
                
                
            case let .failure(error):
//                print(searchApp.baseURL)
//                print(searchApp.path)
//                print(searchApp.task)
                print("실패")
                print(error)
                
            }
        }
    }
}

