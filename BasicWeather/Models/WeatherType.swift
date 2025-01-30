//
//  WeatherType.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-29.
//

import UIKit

enum WeatherType{
    case rainy, sunny, clear, cloudy, snowy, foggy, misty, windy, unavailable
    
    init(_ description: String) {
        switch description.lowercased() {
        case let str where str.contains("rain"):
            self = .rainy
        case let str where str.contains("sun"):
            self = .sunny
        case let str where str.contains("clear"):
            self = .clear
        case let str where str.contains("cloud"):
            self = .cloudy
        case let str where str.contains("snow"):
            self = .snowy
        case let str where str.contains("fog"):
            self = .foggy
        case let str where str.contains("mist"):
            self = .misty
        case let str where str.contains("wind"):
            self = .windy
        default:
            self = .unavailable
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .rainy:
            return UIImage(systemName: "cloud.rain.fill")
        case .sunny, .clear:
            return UIImage(systemName: "sun.max.fill")
        case .cloudy:
            return UIImage(systemName: "cloud.fill")
        case .snowy:
            return UIImage(systemName: "snowflake")
        case .foggy, .misty:
            return UIImage(systemName: "cloud.fog.fill")
        case .windy:
            return UIImage(systemName: "wind")
        case .unavailable:
            return nil
        }
    }
}
