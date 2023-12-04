//
//  WeatherManager.swift
//  Clima
//
//  Created by Ajay Kumar on 12/11/23.

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=87654745f6f96fc6b3e187258dc908b1&q=london&units=metric"
    
    var delegate: WeatherManagerDelegate?
    func fetchWether(cityName: String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    
    func fetchWeather(latitude: CLLocationDegrees, langitude: CLLocationDegrees) {
        
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(langitude)"
        performRequest(with: urlString)
        
    }
    
    
    
    func performRequest(with urlString: String){
        
        //1. create URL
        if let url = URL(string: urlString){
            
            //2. create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session Task
            let task = session.dataTask(with: url) { ( data, response, error ) in
                if error != nil {
                    print(error)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    let weather =  self.jsonParsing(safeData)
                    self.delegate?.didUpdateWeather(self, weather: weather!)
                }
            }
            //4. start the task
            task.resume()
        }
        
    }
    
    func jsonParsing(_ weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodeData.name)
            print(decodeData.cod)
            print(decodeData.main.temp)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            let weather = WeatherModel(conditionId: id, temprature: temp, cityName: name)
            return weather
            print(weather.conditionName)
            //print("visibility",decodeData.visibility)
        }catch{
            print(error)
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
        
    }
    
