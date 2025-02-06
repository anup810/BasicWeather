//
//  SearchVC.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-30.
//

import UIKit

protocol SearchVCDelegate where Self: HomeVC{
    func didSelect(_ location: SearchLocation)
}

class SearchVC: UIViewController {
    weak var delegate: SearchVCDelegate?
    let locationManger = LocationManager.shared
    
    private var timer = Timer()
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
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {[weak self] _ in
            guard let self else {return }
            let searchResult = searchController.searchResultsController as! SearchResultVC
            searchResult.delegate = self
            searchResult.update(text: text)
            timer.invalidate()
        }
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let locations = locationManger.getLocation()
            locationManger.delete(locations[indexPath.row])
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let locations = locationManger.getLocation()
        let location = locations[indexPath.row]
        delegate?.didSelect(location)
        locationManger.savedLocation(location)
        navigationController?.popViewController(animated: true)
        
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
