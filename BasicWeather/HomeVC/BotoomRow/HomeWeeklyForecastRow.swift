//
//  HomeWeeklyForecastRow.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-22.
//

import UIKit

class HomeWeeklyForecastRow: UITableViewCell {
    static let id = "HomeWeeklyForecastRow"

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
    func config(){
        
    }

}
extension HomeWeeklyForecastRow: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyForecastDetailRow.id, for: indexPath) as! WeeklyForecastDetailRow
        return cell
    }
    
    
}
extension HomeWeeklyForecastRow: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
