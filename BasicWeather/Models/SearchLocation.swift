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
    
}
