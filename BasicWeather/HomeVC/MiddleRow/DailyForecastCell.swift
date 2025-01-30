//
//  DailyForecastCell.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-23.
//

import UIKit

class DailyForecastCell: UICollectionViewCell {
    
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var img: UIImageView!
    static let id = "DailyForecastCell"
    func configure(_ item: WeeklyForecastList){
        
        timeLabel.text = item.dt_txt
        tempLabel.text = "\(item.main?.temp ?? 0)"
        
        if let description = item.weather?.first?.main{
            let weather = WeatherType(description)
            img.image = weather.icon
            
        }
        else{
            img.image = nil
        }
    }
    
}
