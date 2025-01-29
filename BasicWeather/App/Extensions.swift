//
//  Extensions.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-29.
//

import Foundation

extension [Double]{
    func average() -> Double{
        var total: Double = 0
        var count: Double = 0
        for num in self{
            total += num
            count += 1
        }
        return total/count
    }
}

extension Int{
    func toDay()-> String{
        let date = Date(timeIntervalSince1970: Double(self))
        return date.formatted(Date.FormatStyle().weekday(.abbreviated))
        
    }
}

extension [WeeklyForecastList]{
    func getDailyForecasts()->[DailyForecast]{
        var dailyForecasts : [DailyForecast] = []
        for item in self{
            guard let dt = item.dt?.toDay(), let low = item.main?.tempMin, let high = item.main?.tempMax else {continue}
            guard dailyForecasts.count > 0 else {
                dailyForecasts.append(parse(using: item))
                continue
            }
            if dailyForecasts.last?.day == dt{
                let j = dailyForecasts.count - 1
                dailyForecasts[j].lows.append(low)
                dailyForecasts[j].highs.append(high)
            }else {
                let newDay = parse(using: item)
                dailyForecasts.append(newDay)
            }
            
        }
        
        return dailyForecasts
        
    }
    
    private func parse(using item: WeeklyForecastList) -> DailyForecast{
        var forecast = DailyForecast(description: item.weather!.first?.main, day: item.dt!.toDay())
        forecast.lows.append(item.main!.tempMin!)
        forecast.highs.append(item.main!.tempMax!)
        return forecast
    }
}
