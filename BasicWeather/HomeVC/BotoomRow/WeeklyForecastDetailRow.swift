//
//  WeeklyForecastDetailRow.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-23.
//

import UIKit

class WeeklyForecastDetailRow: UITableViewCell {
    static let id = "WeeklyForecastDetailRow"

    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var maxTemp: UILabel!
    @IBOutlet private weak var minTemp: UILabel!
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var dailyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(_ forecast : DailyForecast){
        dailyLabel.text = forecast.day
        let low = forecast.lows.average()
        let high = forecast.highs.average()
        
        let lowInt = Int(low)
        let highInt = Int(high)
        minTemp.text = "\(lowInt)"
        maxTemp.text = "\(highInt)"
        
        slider.minimumValue = Float(low)
        slider.maximumValue = Float(high)
        let average = forecast.average
        slider.value = Float(average)
        
        if let description = forecast.description{
            let weather = WeatherType(description)
            img.image = weather.icon
            img.tintColor = weather.tint
        }
        else {
            img.image = nil
        }
    }

}
