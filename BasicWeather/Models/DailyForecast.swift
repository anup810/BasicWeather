//
//  DailyForecast.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-29.
//

import UIKit
struct DailyForecast{
    let description: String?
    let day: String
    
    var lows: [Double] = []
    var highs: [Double] = []
    var average: Double{
        return (lows.average() + highs.average()) / 2
        
    }
}
