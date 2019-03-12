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
    
    /// Search controller to help us with filtering.
    private var searchController: UISearchController!
    
    /// Secondary search results table view.
    private var searchResultsVC: SearchResultViewController!
    
    //LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHistoryData()
        
        searchResultsVC = SearchResultViewController()
        searchResultsVC.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: searchResultsVC )
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
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    
    func loadHistoryData()  {
        //Database -> History 불러와서 저장.
        historyStringList.append("1")
        historyStringList.append("2")
        historyStringList.append("3")
    }
    
}


//UITableView Delegate
extension SearchViewController  {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell") as! HistoryTableViewCell
        cell.historyTitle.setTitle(filteredData[indexPath.row], for: .normal)
        
        return cell
    }
}

//UISearchControllerDelegate
extension SearchViewController : UISearchControllerDelegate  {
    
}

//UISearchBarDelegate
extension SearchViewController : UISearchBarDelegate  {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//UISearchResultUpdating
extension SearchViewController : UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        <#code#>
    }
    
    
}


//Table View Cell
class HistoryTableViewCell : UITableViewCell  {
    @IBOutlet weak var historyTitle: UIButton!
}
