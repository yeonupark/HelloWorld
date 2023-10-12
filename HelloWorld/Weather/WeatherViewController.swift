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
    }
    
    func setLabel() {
        mainView.placeLabel.text = "[ \(viewModel.placeName) ]"
    }
    
    func getWorldTime() {
        let city = "london".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/worldtime?city="+city!)!
        var request = URLRequest(url: url)
        request.setValue("YOUR_API_KEY", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
}
