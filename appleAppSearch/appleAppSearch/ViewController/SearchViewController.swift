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
    let networking = Networking()
    let historyDatabase = DatabaseProces()
    var historyStringList = [String]()
    
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
        
    }
    
    
    func loadHistoryData()  {
        //Database -> History 불러와서 저장.
        historyStringList.removeAll()
        let historyData = historyDatabase.realm.objects(History.self).distinct(by:["historyTitle"])
        var listIndex = 0
        for dataIndex in stride(from: historyData.count - 1, to: 0, by: -1)  {
            historyStringList.insert(historyData[dataIndex].historyTitle, at: listIndex)
            listIndex += 1
        }
        
        
    
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
        log.verbose(searchController.isActive)
        if self.searchController.isActive == false  {
            self.searchController.isActive = true
            self.searchController.searchBar.text = historyStringList[indexPath.row]
            updateSearchResults(for: self.searchController)
            searchBar(self.searchController.searchBar,textDidChange: historyStringList[indexPath.row])
            searchBarSearchButtonClicked(self.searchController.searchBar)
        }  else {
            guard let detailInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailInfo") as? DetailViewController else {
                log.error("detail False")
                return
            }
            self.navigationController?.pushViewController(detailInfoViewController, animated: true)
            
            
        }
    }
}

//UISearchControllerDelegate
extension SearchViewController : UISearchControllerDelegate  {
    
}

//UISearchBarDelegate
extension SearchViewController : UISearchBarDelegate  {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchListVC.filteredResult = searchText.isEmpty ? historyStringList : historyStringList.filter({(dataString:String) -> Bool in
            return dataString.range(of: searchText,options: .caseInsensitive) != nil
        })
        self.searchListVC.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchListVC.isSearching = false
        searchListVC.searchedWord = searchBar.text!
        //Searching to Network
        networking.AppleSearch(words: searchController.searchBar.text!) { response in
            log.verbose(response.resultCount)
            self.searchListVC.searchReesultData = response
            self.searchListVC.tableView.reloadData()

        }
        
        //input Database
        guard let searchingText = searchBar.text else {
            log.verbose("Fail input data")
            return
        }
        let inputDataToDB = History()
        inputDataToDB.historyTitle = searchingText
        historyDatabase.writeDatabase(value: inputDataToDB)
        log.verbose("success input data")
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        historyDatabase.realm.refresh()
        loadHistoryData()
        tableView.reloadData()
        self.searchController.isActive = false
        
    }
}

//UISearchResultUpdating
extension SearchViewController : UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let resultsController = searchController.searchResultsController as? SearchListController  {
            resultsController.isSearching = true
            resultsController.tableView.reloadData()
        }
        
    }
}


//Table View Cell
class HistoryTableViewCell : UITableViewCell  {
    @IBOutlet weak var historyTitle: UILabel!
}

