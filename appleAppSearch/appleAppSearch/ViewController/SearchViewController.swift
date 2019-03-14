//
//  TestViewController.swift
//  appleAppSearch
//
//  Created by 양현준 on 12/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//
import UIKit

class SearchViewController : UITableViewController {
    
    //Properties
    var filteredData : [String]!
    var historyStringList = [String]()
    let networking = Networking()
    
    /// Search controller to help us with filtering.
    private var searchController: UISearchController!
    
    /// Secondary search results table view.
    private var searchListVC: SearchListController!

    
    //LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHistoryData()
        
        searchListVC = SearchListController()
        searchListVC.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: searchListVC )
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        if #available(iOS 11.0, *) {
            // For iOS 11 and later, place the search bar in the navigation bar.
            navigationItem.searchController = searchController
            // Make the search bar always visible.
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // For iOS 10 and earlier, place the search controller's search bar in the table view's header.
            tableView.tableHeaderView = searchController.searchBar
        }
        
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        filteredData = historyStringList
    }
    
    
    func loadHistoryData()  {
        //Database -> History 불러와서 저장.
        historyStringList.append("wrapsody")
        historyStringList.append("wrapsody")
        historyStringList.append("wrapsody")
        historyStringList.append("wrapsody")
        historyStringList.append("wrapsody")
        historyStringList.append("wrapsody")
        historyStringList.append("wrapsody")
        historyStringList.append("wrapsody")
        historyStringList.append("wrapsody")
        historyStringList.append("wrapsody")
    }
    
}


//UITableView Delegate
extension SearchViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let historyListNumber = 7
        if historyStringList.count > historyListNumber  {
            return historyListNumber
        } else {
            return historyStringList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyViewCell") as! HistoryTableViewCell
        cell.historyTitle.text = historyStringList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchController.isActive = true
        self.searchController.searchBar.text = historyStringList[indexPath.row]
        updateSearchResults(for: self.searchController)
        searchBar(self.searchController.searchBar,textDidChange: historyStringList[indexPath.row])
        searchBarSearchButtonClicked(self.searchController.searchBar)
    }
}

//UISearchControllerDelegate
extension SearchViewController : UISearchControllerDelegate  {
    
}

//UISearchBarDelegate
extension SearchViewController : UISearchBarDelegate  {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? historyStringList : historyStringList.filter({(dataString:String) -> Bool in
            return dataString.range(of: searchText,options: .caseInsensitive) != nil
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchListVC.isSearching = false
        searchListVC.tableView.rowHeight = UITableView.automaticDimension
        networking.AppleSearch(words: searchController.searchBar.text!) { response in
            log.verbose(response.resultCount)
            self.searchListVC.searchReesultData = response
            self.searchListVC.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.isActive = false
    }
}

//UISearchResultUpdating
extension SearchViewController : UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let resultsController = searchController.searchResultsController as? SearchListController  {
            resultsController.isSearching = true
            // TODO :  Database History Filter
//            resultsController.tableView.reloadData()
        }
        
    }
}


//Table View Cell
class HistoryTableViewCell : UITableViewCell  {
    @IBOutlet weak var historyTitle: UILabel!
}

