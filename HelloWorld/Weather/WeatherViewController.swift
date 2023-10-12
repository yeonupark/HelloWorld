//
//  WeatherViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/12.
//

import UIKit

class WeatherViewController: BaseViewController {
    
    let mainView = WeatherView()
    override func loadView() {
        view.self = mainView
    }
    
    let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        
        setLabel()
        //getWorldTime()
    }
    
    func setLabel() {
        mainView.placeLabel.text = "[ \(viewModel.placeName) ]"
    }
    
    func getWorldTime() {
        WorldTimeAPIManager.shared.callRequest(lat: viewModel.latitude, lon: viewModel.longitude) { data in
            self.mainView.dateLabel.text =  data?.date
            guard let hour = data?.hour else { return }
            guard let minute = data?.minute else { return }
            self.mainView.timeLabel.text = "\(hour) : \(minute)"
        }
    }
}
