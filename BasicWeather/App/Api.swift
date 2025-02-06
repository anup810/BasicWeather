//
//  Api.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-01-28.
//

import Foundation

class Api{
    static let shared = Api()
    private init(){}
    
    // MARK: - GENERIC FUNCTION
    
    func fetchSample<T:Decodable>(_ type: T.Type, completion:@escaping(T?)-> Void){
        let resource = getResource(type)
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else {
            completion(nil)
            return
        }
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
        do{
            let data = try Data(contentsOf: url)
            let decodedData = try decoder.decode(type, from: data)
            completion(decodedData)
            
        }catch{
            print(error)
            completion(nil)
        }
        
    }
    
    private func getResource<T>(_ type: T.Type) -> String{
        return switch type{
        case is CurrentWeather.Type:
            "CurrentWeather"
        case is WeeklyForecast.Type:
            "WeeklyForecast"
        case is [SearchLocation].Type:
            "SearchLocation"
        default:
            ""
        }
        
    }
  

    
    
    //MARK: - LIVE DATA
   
    // fetch weather from lat and lon
    func fetchWeather(lat: Double, lon: Double, completion: @escaping(CurrentWeather?)-> Void){
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "Api_Key") as? String else{
            print("Api key is missing")
            completion(nil)
            return
        }
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=imperial"
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard  error == nil, let data else{
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do{
                let decodedData  = try decoder.decode(CurrentWeather.self, from: data)
                completion(decodedData)
                
            }catch{
                print(error)
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    
    func fetchCurrentWeatherLive(completion: @escaping(CurrentWeather?) -> Void){
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "Api_Key") as? String else {
            print("API Key is missing")
            completion(nil)
            return
        }
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(apiKey)&units=imperial"
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data else{
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(CurrentWeather.self, from: data)
                completion(decodedData)
                
            }catch{
                print(error)
                completion(nil)
                
            }
        }
        task.resume()
        
    }
 
}
