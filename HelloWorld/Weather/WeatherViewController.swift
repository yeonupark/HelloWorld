//
//  WeatherViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/12.
//

import UIKit
import WeatherKit
import CoreLocation

class WeatherViewController: BaseViewController {
    
    let mainView = WeatherView()
    override func loadView() {
        view.self = mainView
    }
    
    let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        
        setLabel()
        getWorldTime()
        getWeather()
        
        mainView.dailyTableView.delegate = self
        mainView.dailyTableView.dataSource = self
        mainView.dailyTableView.rowHeight = 40
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openWebsite))
        mainView.weatherSourceLabel.addGestureRecognizer(tapGesture)
        mainView.weatherSourceLabel.isUserInteractionEnabled = true
    }
            
    @objc func openWebsite() {
        if let url = URL(string: "https://developer.apple.com/weatherkit/data-source-attribution/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func setLabel() {
        mainView.placeLabel.text = "[ \(viewModel.placeName) ]"
    }
    
    func getWorldTime() {
        
        if viewModel.longitude > 124 && viewModel.longitude < 132 && viewModel.latitude > 33 && viewModel.latitude < 43 {
            mainView.timeView.isHidden = true
            return
        }
        
        WorldTimeAPIManager.shared.callRequest(lat: viewModel.latitude, lon: viewModel.longitude) { data in
            self.mainView.dateLabel.text =  data?.date
            guard let hour = data?.hour else { return }
            guard let minute = data?.minute else { return }
            self.mainView.timeLabel.text = "\(hour) : \(minute)"
        }
    }
    
    func getWeather() {
        
        let location = CLLocation(latitude: viewModel.latitude, longitude: viewModel.longitude)
        
        Task {
            do {
                let weather = try await WeatherService.shared.weather(for: location)
                
                let currentWeather = weather.currentWeather
                let temp = currentWeather.temperature.value
                mainView.currentTempLabel.text = "\(Int(temp))°C"
                mainView.currentConditionImage.image = UIImage(named: currentWeather.symbolName)
                let dailyWeather = weather.dailyForecast
                for day in dailyWeather {
                    let date = viewModel.dateFormat(date: day.date)
                    
                    let data = DailyWeather(date: String(date), conditionSymbol: day.symbolName, highestTemp: "\(Int(day.highTemperature.value))°C", lowerstTemp: "\(Int(day.lowTemperature.value))°C")
                    viewModel.dailyWeatherList.append(data)
                }
                
                mainView.dailyTableView.reloadData()
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dailyWeatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        
        let data = viewModel.dailyWeatherList[indexPath.row]
        cell.dateLabel.text = data.date
        cell.symbolImage.image = UIImage(named: data.conditionSymbol)
        cell.tempLabel.text = "\(data.lowerstTemp)  ~  \(data.highestTemp)"
        return cell

    }
}
