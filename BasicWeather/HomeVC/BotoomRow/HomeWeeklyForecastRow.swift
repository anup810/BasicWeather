//
//  HomeWeeklyForecastRow.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-22.
//

import UIKit

class HomeWeeklyForecastRow: UITableViewCell {
    static let id = "HomeWeeklyForecastRow"
    private var dailyForecast: [DailyForecast] = []
    
    @IBOutlet private weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupHomeWeeklyForecastRow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    private func setupHomeWeeklyForecastRow(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    func configure(_ forecast: WeeklyForecast?){
        guard let list = forecast?.list else {return}
        dailyForecast = list.getDailyForecasts()
        tableView.reloadData()
        
        
    }
  
    
}
extension HomeWeeklyForecastRow: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecast.count > 5 ? 5 : dailyForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyForecastDetailRow.id, for: indexPath) as! WeeklyForecastDetailRow
        let forecast = dailyForecast[indexPath.row]
        cell.configure(forecast)
       
        return cell
    }
    
    
}
extension HomeWeeklyForecastRow: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
