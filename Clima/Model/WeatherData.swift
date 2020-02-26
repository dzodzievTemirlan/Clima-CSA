//
//  WeatherData.swift
//  Clima
//
//  Created by Temirlan Dzodziev on 06.02.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    
    
}
struct Main: Codable {
    let temp: Double
    let temp_min: Double
}

struct Weather: Codable{
    let id: Int
    let description: String
}


