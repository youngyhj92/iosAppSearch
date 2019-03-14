//
//  SearchResultController.swift
//  appleAppSearch
//
//  Created by 양현준 on 12/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//
import UIKit
import Kingfisher

class SearchListController :UITableViewController {
    
    var isSearching = true
    
//    var filteredResult = [String]()
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

        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchReesultData.resultCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearching  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchList", for: indexPath)
            if resultContents == nil {
                cell.textLabel?.text = nil
            } else {
                cell.textLabel?.text = resultContents![indexPath.row].trackName
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchResult") as! SearchResultCell
            tableView.rowHeight = UITableView.automaticDimension
            let rowAppInfo = resultContents?[indexPath.row]
            let logoImageSet = RoundCornerImageProcessor(cornerRadius: 20)
            let screenShotImageSet = RoundCornerImageProcessor(cornerRadius: 50)
            cell.appTitle.text = rowAppInfo?.trackName
            cell.appCategory.text = rowAppInfo?.primaryGenreName
            cell.appRating.text = rowAppInfo?.trackContentRating
            cell.logoImage.kf.setImage(with:rowAppInfo?.artworkUrl100,options:[.processor(logoImageSet)])
            cell.explainImage1.kf.setImage(with: rowAppInfo?.screenshotUrls?[0], options:[.processor(screenShotImageSet)])
            cell.explainImage2?.kf.setImage(with: rowAppInfo?.screenshotUrls?[1],options:[.processor(screenShotImageSet)])
            cell.explainImage3?.kf.setImage(with: rowAppInfo?.screenshotUrls?[2],options:[.processor(screenShotImageSet)])
            return cell
        }
     
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      
        
    }
    
}

class SearchResultCell : UITableViewCell  {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appCategory: UILabel!
    @IBOutlet weak var appRating: UILabel!
    @IBOutlet weak var explainImage1: UIImageView!
    @IBOutlet weak var explainImage2: UIImageView?
    @IBOutlet weak var explainImage3: UIImageView?
}
