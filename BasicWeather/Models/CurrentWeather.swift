//
//  CurrentWeather.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-24.
//

import Foundation

struct CurrentWeather: Codable{
    let coord: Coordinates
    let weather:[CurrentWeatherWeather]
    let base: String
    let main : CurrentWeatherMain
    let visibility: Int
    let wind: CurrentWeatherWind
    let clouds: CurrentWeatherClouds
    let dt : Int
    let sys: CurrentWeatherSys
    let timezone: Double
    let id: Int
    let name: String
    let cod:Int
    
}
struct Coordinates: Codable{
    let lon: Double
    let lat: Double
}

struct CurrentWeatherWeather: Codable{
    let id: Int
    let main: String
    let description: String
    let icon: String
}
struct CurrentWeatherMain: Codable{
    let temp: Double
    let feels_like: Double
    let temp_min : Double
    let temp_max : Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int
    let grnd_level: Int
}
struct CurrentWeatherWind: Codable{
    let speed: Double
    let deg: Int
}

struct CurrentWeatherClouds: Codable{
    let all :Int
}

struct CurrentWeatherSys: Codable{
    let type : Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

