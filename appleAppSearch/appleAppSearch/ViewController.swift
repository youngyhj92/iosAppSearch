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
         let provider = MoyaProvider<SearchAppleRepo>()
        provider.request(.term(searchStr: "wrapsody"))  {  result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                print(data)
            case let .failure(error):
                print(error)
                
            }
        }
    }


}

