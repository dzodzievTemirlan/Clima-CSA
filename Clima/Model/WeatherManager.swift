//
//  WeatherManager.swift
//  Clima
//
//  Created by Temirlan Dzodziev on 06.02.2020.
//  Copyright © 2020 Temirlan Dzodziev. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ WeatherManager: WeatherManager ,weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
   
    var delegate: WeatherManagerDelegate?
    let wetherURL = "Здесь должна быть ссылка / here should be a link here"
    
    
    func fetchWeather(cityName:String){
        let urlString = "\(wetherURL)&q=\(cityName)"
        performRequest(with: urlString)
        }
    
    func fetchWeather (latitude: CLLocationDegrees, longitute: CLLocationDegrees){
        let urlString = "\(wetherURL)&lat=\(latitude)&lon=\(longitute)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJson(safeData){
                        self.delegate?.didUpdateWeather(self, weather:weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ weatherData: Data) ->  WeatherModel?{
        let decoder = JSONDecoder()
        do{
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        }catch{
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
}

