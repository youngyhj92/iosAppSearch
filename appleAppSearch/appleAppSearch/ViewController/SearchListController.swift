//
//  SearchResultController.swift
//  appleAppSearch
//
//  Created by 양현준 on 12/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//
import UIKit
import Foundation
import Kingfisher

class SearchListController :UITableViewController {
    
    var isSearching = true
    var searchedWord = ""
    var filteredResult = [String]()
    /// Search controller to help us with filtering.
    private var searchController: UISearchController!
    
    var searchReesultData = SearchResponse(resultCount:-1, results:nil)
    lazy var resultContents : [AppInformation]? = {
        return searchReesultData.results
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchingNib = UINib(nibName: "SearchListCell", bundle: nil)
        tableView.register(searchingNib, forCellReuseIdentifier: "searchList")
        
        let searchedNib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(searchedNib, forCellReuseIdentifier: "searchResult")
        
        let searchedNoneNib = UINib(nibName: "SearchNoneCell", bundle: nil)
        tableView.register(searchedNoneNib, forCellReuseIdentifier: "searchNone")

        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching  {
            return filteredResult.count
        } else {
            if searchReesultData.resultCount == 0  {
                return 1
            } else {
                return searchReesultData.resultCount
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearching {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchList", for: indexPath)
                cell.textLabel?.text = filteredResult[indexPath.row]
            return cell
            
        } else {
            if searchReesultData.resultCount == 0  {
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchNone", for: indexPath) as! SearchResultNoneCell
                cell.searchWord.text = searchedWord
                return cell
            } else  {
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult") as! SearchResultCell
                let rowAppInfo = resultContents?[indexPath.row]
                let logoImageSet = RoundCornerImageProcessor(cornerRadius: 20)
                let screenShotImageSet = RoundCornerImageProcessor(cornerRadius: 50)
                cell.appTitle.text = rowAppInfo!.trackName
                cell.appCategory.text = rowAppInfo!.primaryGenreName
                cell.appRating.text = rowAppInfo!.trackContentRating
                cell.logoImage.kf.setImage(with:rowAppInfo!.artworkUrl100,options:[.processor(logoImageSet)])
                cell.explainImage1.kf.setImage(with: rowAppInfo!.screenshotUrls?[0], options:[.processor(screenShotImageSet)])
                cell.explainImage2.kf.setImage(with: rowAppInfo!.screenshotUrls?[1],options:[.processor(screenShotImageSet)])
                cell.explainImage3.kf.setImage(with: rowAppInfo!.screenshotUrls?[2],options:[.processor(screenShotImageSet)])
                return cell
            }
        }
     
    }
}

class SearchResultCell : UITableViewCell  {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appCategory: UILabel!
    @IBOutlet weak var appRating: UILabel!
    @IBOutlet weak var explainImage1: UIImageView!
    @IBOutlet weak var explainImage2: UIImageView!
    @IBOutlet weak var explainImage3: UIImageView!
}

class SearchResultNoneCell : UITableViewCell  {
    
    @IBOutlet weak var searchWord: UILabel!
}
