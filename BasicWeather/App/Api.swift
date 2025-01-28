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
    
    func fetchCurrentWeather(completion: @escaping (CurrentWeather?)-> Void){
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
}
