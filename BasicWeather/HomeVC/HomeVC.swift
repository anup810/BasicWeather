//
//  ViewController.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-22.
//

import UIKit

class HomeVC: UIViewController {
    private var currentWeather: CurrentWeather?
    private var weeklyForecastWeather: WeeklyForecast?
    let locationManager = LocationManager.shared
    
    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        if let location = locationManager.getSelectedLocation(){
            //fetch data from apis
            fetchWeather(for: location)
        }else{
            let vc = SearchVC()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
  
    }
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    private func fetchWeather(for location: SearchLocation){
        Api.shared.fetchWeather(lat: location.lat, lon: location.lon) {[weak self] weather, forecast in
            guard let weather, let forecast ,let self else {return}
            currentWeather = weather
            weeklyForecastWeather = forecast
            tableView.reloadData()
            
            
        }
        
//        Api.shared.fetchWeather(lat: location.lat, lon: location.lon) { weather in
//            guard let weather else {return}
//            print("We received data hera!")
//            DispatchQueue.main.async { [weak self] in
//                guard let self else {return}
//                currentWeather = weather
//                tableView.reloadData()
//                
//            }
//        }
//        Api.shared.fetchForecast(lat: location.lat, lon: location.lon) { forecast in
//            guard let forecast else {return}
//            DispatchQueue.main.async { [weak self] in
//                guard let self else {return}
//                weeklyForecastWeather = forecast
//                tableView.reloadData()
//            }
//        }
        
    }
    
    @IBAction func didTapListButton(_ sender: UIBarButtonItem) {
        let vc = SearchVC()
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension HomeVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTopRow.id, for: indexPath) as! HomeTopRow
            cell.configure(currentWeather)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCarouselRow.id, for: indexPath) as! HomeCarouselRow
            cell.configure(weeklyForecastWeather)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeWeeklyForecastRow.id, for: indexPath) as! HomeWeeklyForecastRow
            cell.configure(weeklyForecastWeather)
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
}
extension HomeVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 175
        case 1:
            return 160
        case 2:
            return 350
        default:
            return 0
        }
    }
    
}

extension HomeVC: SearchVCDelegate{
    func didSelect(_ location: SearchLocation) {
        //fetch data
        fetchWeather(for: location)

    }
    
    
}


