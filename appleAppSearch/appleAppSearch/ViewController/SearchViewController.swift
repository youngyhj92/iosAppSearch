//
//  ViewController.swift
//  appleAppSearch
//
//  Created by hyunjun yang on 03/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit

class TestViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var appSearchBar: UISearchBar!
    
    let networking = Networking()
    var filteredData : [String]!
    var historyStringList = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // History Table View 설정
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        //SeachBar delegate 설정
        appSearchBar.delegate = self
        
        //filtering 값과 원본 배열 값을 동일하게 복사함.
        loadHistoryData()
        self.filteredData = self.historyStringList
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    func loadHistoryData()  {
        //Database -> History 불러와서 저장.
        historyStringList.append("1")
        historyStringList.append("2")
        historyStringList.append("3")
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //사용자가 값을 입력할 때 필터 영역을 결정하는 메소드
        filteredData = searchText.isEmpty ? historyStringList : historyStringList.filter({(dataString:String) -> Bool in
            return dataString.range(of: searchText,options: .caseInsensitive) != nil
        })
        
        historyTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Search Button Clicked
        guard let searchText = self.appSearchBar.text else {
            return
        }
        networking.AppleSearch(words: searchText) { response in
            log.verbose("Final : " + String(response.resultCount))
            guard let resultVC = self.storyboard?.instantiateViewController(withIdentifier:"resultViewController") as? SearchResultViewController else {
                return
            }
            resultVC.searchReesultData = response
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //Searchbar에 글자 입력 시작
        self.appSearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //Searchbar cancel 버튼 클릭시 동작
        self.appSearchBar.showsCancelButton = false
        self.appSearchBar.text = ""
        self.appSearchBar.resignFirstResponder()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell") as! HistoryTableViewCell
        cell.historyTitle.setTitle(self.filteredData[indexPath.row], for: .normal)
        
        return cell
    }
    
    @IBAction func historyLabelClicked(_ sender: UIButton) {
        self.appSearchBar.text = sender.titleLabel?.text
        searchBarSearchButtonClicked(self.appSearchBar)
    }
}

