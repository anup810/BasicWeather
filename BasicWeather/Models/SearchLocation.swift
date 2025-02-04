//
//  SearchLocation.swift
//  BasicWeather
//
//  Created by Anup Saud on 2025-02-04.
//

import Foundation

struct SearchLocation: Codable{
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    static func == (lhs: SearchLocation, rhs: SearchLocation) -> Bool{
        return (lhs.name == rhs.name && lhs.country == rhs.country && lhs.state == rhs.state) || (lhs.lat == rhs.lat && lhs.lon == rhs.lon)
        
    }
    
}
