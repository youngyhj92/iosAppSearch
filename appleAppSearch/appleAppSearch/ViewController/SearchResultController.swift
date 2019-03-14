//
//  SearchResultViewController.swift
//  appleAppSearch
//
//  Created by hyunjun yang on 10/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit

class SearchResultController : UITableViewController  {
    
    var searchReesultData = SearchResponse(resultCount:-1, results:nil)
    lazy var resultContents : [AppInformation]? = {
        return searchReesultData.results
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        log.verbose(searchReesultData.resultCount)
        let nib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "searchResult")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchReesultData.resultCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult", for: indexPath)
        
        if resultContents == nil {
            cell.textLabel?.text = "None"
        } else {
            cell.textLabel?.text = resultContents![indexPath.row].trackName
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.verbose("Success")
    }

}
