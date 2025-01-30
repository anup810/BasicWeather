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
    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        Api.shared.fetchCurrentWeatherLive{ weather in
//            guard let weather else {return}
//            print("Recived Data")
//            DispatchQueue.main.async { [weak self] in
//                self?.currentWeather = weather
//                self?.tableView.reloadData()
//            }
//   
//        }
        Api.shared.fetchSample(CurrentWeather.self) { weather in
            guard let weather else {return}
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                currentWeather = weather
                tableView.reloadData()
            }
        }
        
        Api.shared.fetchSample(WeeklyForecast.self) { forecast in
            guard let forecast else {return}
            DispatchQueue.main.async {[weak self] in
                guard let self else {return}
                weeklyForecastWeather = forecast
                tableView.reloadData()
            }
        }


    }
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    @IBAction func didTapListButton(_ sender: UIBarButtonItem) {
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


