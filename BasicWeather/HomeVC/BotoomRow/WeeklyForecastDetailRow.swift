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
    func configure(){
        
    }

}
