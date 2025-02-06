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
    
    private var apiKey: String?{
        return Bundle.main.object(forInfoDictionaryKey: "Api_Key") as? String
    }

    enum Endpoint: String {
        case currrentWeather = "/data/2.5/weather"
        case weeklyForecast = "/data/2.5/forecast"
        case citySearch = "/geo/1.0/direct"
    }
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
    private func fetch<T: Decodable>(_ type: T.Type, _ request: URLRequest, completion: @escaping(T?)-> Void){
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(type, from: data)
                completion(decodedData)
            }catch{
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
    private func constructURL(for endpoint: Endpoint, _ lat: Double? = nil, _ lon: Double? = nil, _ city: String? = nil) -> URLRequest? {
          var components = URLComponents()
          components.scheme = "https"
          components.host = "api.openweathermap.org"
          components.path = endpoint.rawValue
          switch endpoint {
          case .currrentWeather, .weeklyForecast:
              guard let lat, let lon else { return nil }
              components.queryItems = [
                  URLQueryItem(name: "lat", value: "\(lat)"),
                  URLQueryItem(name: "lon", value: "\(lon)"),
                  URLQueryItem(name: "units", value: "metric"),
                  URLQueryItem(name: "appid", value: apiKey)
              ]
          case .citySearch:
              guard let city else { return nil }
              components.queryItems = [
                  URLQueryItem(name: "q", value: city),
                  URLQueryItem(name: "limit", value: "\(10)"),
                  URLQueryItem(name: "appid", value: apiKey)
              ]
          }
          guard let url = components.url else { return nil }
          var request = URLRequest(
              url: url,
              cachePolicy: .useProtocolCachePolicy,
              timeoutInterval: 10)
          request.httpMethod = "GET"
          return request
      }
      
    func fetchWeather(lat: Double , lon: Double, completion: @escaping((CurrentWeather?, WeeklyForecast?))-> Void){
        //call fetch twice for currentWeather and WeeklyForecast Object
        guard let currentWeather = constructURL(for: .currrentWeather, lat, lon, nil), let weeklyForecast = constructURL(for: .weeklyForecast, lat , lon, nil) else {
            completion((nil, nil))
            return
        }
        var weather: CurrentWeather?
        var forecast : WeeklyForecast?
        let group = DispatchGroup()
        group.enter()
        fetch(CurrentWeather.self, currentWeather) { result in
            weather = result
            group.leave()
        }
        group.enter()
        fetch(WeeklyForecast.self, weeklyForecast) { result in
            forecast = result
            group.leave()
        }
        
        group.notify(queue: .main){
            completion((weather, forecast))
        }

        
    }
    func fetchLocation(city: String, completion:@escaping([SearchLocation]?)-> Void){
        // construct URLRequest object for the fetch function for searching a location
        guard let search = constructURL(for: .citySearch, nil , nil, city) else {
            completion(nil)
            return
        }
        fetch([SearchLocation].self, search) { result in
            completion(result)
        }
    }
//    // fetch weather from lat and lon
//    func fetchWeather(lat: Double, lon: Double, completion: @escaping(CurrentWeather?)-> Void){
//        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "Api_Key") as? String else{
//            print("Api key is missing")
//            completion(nil)
//            return
//        }
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
//        
//        let url = URL(string: urlString)!
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard  error == nil, let data else{
//                completion(nil)
//                return
//            }
//            let decoder = JSONDecoder()
//            do{
//                let decodedData  = try decoder.decode(CurrentWeather.self, from: data)
//                completion(decodedData)
//                
//            }catch{
//                print(error)
//                completion(nil)
//            }
//            
//        }
//        task.resume()
//    }
//    func fetchForecast(lat: Double, lon: Double, completion: @escaping(WeeklyForecast?)-> Void){
//        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "Api_Key") as? String else{
//            print("Api key is missing")
//            completion(nil)
//            return
//        }
//        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
//        
//        let url = URL(string: urlString)!
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard  error == nil, let data else{
//                completion(nil)
//                return
//            }
//            let decoder = JSONDecoder()
//            do{
//                let decodedData  = try decoder.decode(WeeklyForecast.self, from: data)
//                completion(decodedData)
//                
//            }catch{
//                print(error)
//                completion(nil)
//            }
//            
//        }
//        task.resume()
//    }
//    
//    func fetchLocation(for city: String , completion:@escaping([SearchLocation]?) -> Void){
//        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "Api_Key") as? String else {
//            print("API Key is missing")
//            completion(nil)
//            return
//        }
//        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=\(apiKey)"
//        let url = URL(string:  urlString)!
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard error == nil, let data else {
//                completion(nil)
//                return
//            }
//            let decoder = JSONDecoder()
//            do{
//                let decodedData = try decoder.decode([SearchLocation].self, from: data)
//                completion(decodedData)
//                
//            }catch{
//                print(error)
//                completion(nil)
//            }
//        }
//        task.resume()
//        
//    }
 
}
