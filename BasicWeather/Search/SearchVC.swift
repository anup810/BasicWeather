//
//  SearchVC.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-30.
//

import UIKit

class SearchVC: UIViewController {
    let locationManger = LocationManager.shared
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
        searchResult.delegate = self
        searchResult.update(text: text)
    }
    
    
}
extension SearchVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let locations = locationManger.getLocation()
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationRow.searchId, for: indexPath) as! LocationRow
        let locations = locationManger.getLocation()
        let loction = locations[indexPath.row]
        cell.configure(loction)
        return cell
    }
    
    
}
extension SearchVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
}

extension SearchVC: SearchResultVCDelegate{
    func didSelect(_ location: SearchLocation) {
        locationManger.appendAndSave(location)
        let locations = locationManger.getLocation()
        let index = IndexPath(row: locations.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [index], with: .automatic)
        tableView.endUpdates()
        search.isActive = false
    }
    
    
}
