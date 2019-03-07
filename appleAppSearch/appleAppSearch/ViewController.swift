//
//  ViewController.swift
//  appleAppSearch
//
//  Created by hyunjun yang on 03/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let searchApp = SearchAppleRepo.term(searchStr: "test")
        
         let provider = MoyaProvider<SearchAppleRepo>()
        provider.request(.term(searchStr: "wrapsody"))  {  result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                print("성공")
                print(data)
            case let .failure(error):
                print(searchApp.baseURL)
                print(searchApp.path)
                print(searchApp.task)
                print("실패")
                print(result.result.error)
                
            }
        }
    }


}

