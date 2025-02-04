//
//  SearchVC.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-30.
//

import UIKit

class SearchVC: UIViewController {
    private lazy var search: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultVC())
        search.searchBar.placeholder = "Search by city"
        search.obscuresBackgroundDuringPresentation = true
        search.hidesNavigationBarDuringPresentation = false
        search.searchResultsUpdater = self
        return search
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        setupUI()
        setupTableView()

    }
    private func setupUI(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LocationRow.self, forCellReuseIdentifier: LocationRow.searchId)
        
    }
}
extension SearchVC : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        let searchResult = searchController.searchResultsController as! SearchResultVC
        searchResult.update(text: text)
    }
    
    
}
extension SearchVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationRow.searchId, for: indexPath) as! LocationRow
        //cell.configure()
        return cell
    }
    
    
}
extension SearchVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
}
