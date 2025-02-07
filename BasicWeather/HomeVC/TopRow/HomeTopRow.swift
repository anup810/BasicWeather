//
//  HomeTopRow.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-22.
//

import UIKit

class HomeTopRow: UITableViewCell {
    static let id = "HomeTopRow"

    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var tempLabel:UILabel!
    @IBOutlet private weak var descriptionLabel:UILabel!
    @IBOutlet private weak var highLowLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(_ weather: CurrentWeather?){
        guard let weather else {return}
        tempLabel.text = "\(weather.main.temp)"
        locationLabel.text = weather.name
        descriptionLabel.text = weather.weather.first?.description
        let low = weather.main.temp_min
        let high = weather.main.temp_max
        highLowLabel.text = "L:\(low)° | H:\(high)°"
        
        if let description = weather.weather.first?.main{
            let weather = WeatherType(description)
            img.image = weather.icon
            img.tintColor = weather.tint
        }else {
            img.image = nil
        }
        
    }

}
