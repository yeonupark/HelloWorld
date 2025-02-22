//
//  WeatherViewModel.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/12.
//

import Foundation

class WeatherViewModel {
    
    var placeName: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    
    var dailyWeatherList: [DailyWeather] = []
    
    func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        let result = dateFormatter.string(from: date)
        
        return result
    }
}

struct DailyWeather {
    let date: String
    let conditionSymbol: String
    let highestTemp: String
    let lowerstTemp: String
}
