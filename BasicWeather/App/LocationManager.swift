//
//  LocationManager.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-02-04.
//

import Foundation

class LocationManager {
    static let shared = LocationManager()
    private init(){}
    private let defaults = UserDefaults.standard
    
    private var locations:[SearchLocation] = []
    
    func getLocation() -> [SearchLocation]{
        if !locations.isEmpty{
            return locations
        }else {
            guard let data = defaults.object(forKey: "Locations") as? [Data] else {
                return []
            }
            do{
                let decoder = JSONDecoder()
                for item in data{
                    let decodedDate = try decoder.decode(SearchLocation.self, from: item)
                    locations.append(decodedDate)
                }
                return locations
            }catch{
                print(error)
                return []
                
            }
        }
        
    }
    
    func appendAndSave(_ location: SearchLocation){
        locations.append(location)
        saveLocation()
        
    }
    
    func delete(_ location: SearchLocation){
        for index in 0..<locations.count{
            guard location == locations[index] else {
                continue
            }
            locations.remove(at: index)
            saveLocation()
            
        }
    }
    private func saveLocation(){
        do{
            var encoded: [Data] = []
            let encoder = JSONEncoder()
            for location in locations{
                let data = try encoder.encode(location)
                encoded.append(data)
            }
            defaults.set(encoded, forKey: "Locations")
            
        }catch{
            print(error)
        }
    }
}
