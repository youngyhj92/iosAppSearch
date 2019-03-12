//
//  SearchResultViewController.swift
//  appleAppSearch
//
//  Created by hyunjun yang on 10/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit

class SearchResultViewController : UITableViewController  {
    
    var searchReesultData = SearchResponse(resultCount:-1, results:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        log.verbose(searchReesultData.resultCount)
        
        
    }
    

}
