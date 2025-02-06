//
//  SearchResultVC.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-02-03.
//

import UIKit

protocol SearchResultVCDelegate where Self: SearchVC{
    func didSelect(_ location: SearchLocation)
}

class SearchResultVC: UIViewController {
    weak var delegate : SearchResultVCDelegate?
    private var locations: [SearchLocation] = []
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LocationRow.self, forCellReuseIdentifier: LocationRow.resultId)
    }
    func update(text: String){
        print(text)
        // Make API request to fetch city data
        Api.shared.fetchLocation(city: text) {locations in
            guard let locations else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                self.locations = locations
                self.tableView.reloadData()
                
            }

        }
    }

}

extension SearchResultVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationRow.resultId, for: indexPath) as! LocationRow
        let location = locations[indexPath.row]
        cell.configure(location)
        return cell
    }
    
    
    
}
extension SearchResultVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let location = locations[indexPath.row]
        delegate?.didSelect(location)
    }
    
}
