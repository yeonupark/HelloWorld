//
//  WeatherView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/12.
//

import UIKit

class WeatherView: BaseView {
    
    let placeLabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        
        return view
    }()
    
    let timeView = {
        let view = UIView()
        
        return view
    }()
    
    let infoLabel = {
        let view = UILabel()
        view.backgroundColor = UIColor(named: "Orange")
        view.text = "[ 현재 시간 ]"
        
        return view
    }()
    
    let dateLabel = {
        let view = UILabel()
        view.backgroundColor = UIColor(named: "Orange")
        view.text = "2023-10-11"
        return view
    }()
    
    let timeLabel = {
        let view = UILabel()
        view.backgroundColor = UIColor(named: "Orange")
        view.text = "22:10"
        return view
    }()
    
    let currentTempLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 25)
        return view
    }()
    
    let currentConditionImage = {
        let view = UIImageView()
        view.tintColor = .black
        return view
    }()
    
    let highestTempLabel = {
        let view = UILabel()
        
        return view
    }()
    
    let lowestTempLabel = {
        let view = UILabel()
        
        return view
    }()
    
    let dailyTableView = {
        let view = UITableView()
        view.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
        
        return view
    }()
    
    override func configure() {
        backgroundColor = .white
        
        for item in [timeView, placeLabel, currentTempLabel, currentConditionImage, highestTempLabel, lowestTempLabel, dailyTableView] {
            addSubview(item)
        }
        
        for item in [infoLabel, dateLabel, timeLabel] {
            timeView.addSubview(item)
        }
    }
    
    override func setConstraints() {
        placeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        timeView.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(30)
            make.size.equalTo(180)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(30)
        }
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        currentConditionImage.snp.makeConstraints { make in
            make.top.equalTo(currentTempLabel.snp.bottom).inset(8)
            make.leading.equalToSuperview().inset(30)
            make.size.equalTo(50)
        }
        dailyTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(currentConditionImage.snp.bottom).offset(50)
            make.bottom.equalToSuperview().inset(100)
        }
    }
}
