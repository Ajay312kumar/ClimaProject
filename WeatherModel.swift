//
//  WeatherModel.swift
//  Clima
//
//  Created by Ajay Kumar on 19/11/23.


import Foundation

struct  WeatherModel{
    
    let conditionId: Int
    let temprature: Double
    let cityName: String
    
    
    var tempratureString: String {
        
        return String(format: "%.1f", temprature)
    }
    
    var conditionName: String {
        switch conditionId {
            
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
            
        }
    }
    
}
