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
    
    //MARK: - SAMPLE DATA
    
    func fetchCurrentWeatherSample(completion: @escaping (CurrentWeather?)-> Void){
        guard let path = Bundle.main.path(forResource: "CurrentWeather", ofType: "json") else {
            completion(nil)
            return
        }
        let url = URL(filePath: path)
        let decoder = JSONDecoder()
        
        do{
            let data = try Data(contentsOf: url)
            let decodedData = try decoder.decode(CurrentWeather.self, from: data)
            completion(decodedData)
            
        }catch{
            print(error)
            completion(nil)
        }
        
    }
    //MARK: - LIVE DATA
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
