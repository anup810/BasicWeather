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
    
    // Selected location for HomeVC
    private var selectedLocation: SearchLocation?
    func getSelectedLocation() -> SearchLocation?{
        if let selectedLocation{
            return selectedLocation
        } else {
            guard let data = defaults.object(forKey: "SelectedLocation") as? Data else {
                return nil
            }
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(SearchLocation.self, from: data)
                selectedLocation = decodedData
                return selectedLocation
                
            }catch{
                print(error)
                return nil
            }
        }
        
    }
    
    // list of loctions for SearchVC
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
        saveLocations()
        
    }
    
    func delete(_ location: SearchLocation){
        for index in 0..<locations.count{
            guard location == locations[index] else {
                continue
            }
            locations.remove(at: index)
            saveLocations()
            
        }
    }
    func savedLocation(_ location: SearchLocation){
        selectedLocation = location
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(location)
            defaults.set(data, forKey: "SelectedLocation")
            
        }catch{
            print(error)
        }
        
    }
    
    private func saveLocations(){
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
