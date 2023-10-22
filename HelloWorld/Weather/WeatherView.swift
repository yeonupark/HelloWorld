//
//  WeatherView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/12.
//

import UIKit

class WeatherView: BaseView {
    
    let backView = {
        let view = UIImageView()
        view.image = UIImage(named: "WaterImage")
        view.layer.opacity = 0.8
        
        return view
    }()
    
    let placeLabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont(name: Constant.FontName.bold, size: 20)
        view.textAlignment = .center
        
        return view
    }()
    
    let timeView = {
        let view = UIView()
        
        return view
    }()
    
    let infoLabel = {
        let view = UILabel()
        view.textColor = Constant.Color.subColor
        view.text = "현재 시간"
        
        return view
    }()
    
    let dateLabel = {
        let view = UILabel()
        view.textColor = Constant.Color.subColor
        return view
    }()
    
    let timeLabel = {
        let view = UILabel()
        view.textColor = Constant.Color.subColor
        return view
    }()
    
    let currentTempLabel = {
        let view = UILabel()
        view.font = UIFont(name: Constant.FontName.bold, size: 20)
        return view
    }()
    
    let currentConditionImage = {
        let view = UIImageView()
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
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
        view.layer.cornerRadius = 15
        view.backgroundColor = Constant.Color.backgroundColor
        return view
    }()
    
    override func configure() {
        backgroundColor = .white
        
        addSubview(backView)
        
        for item in [timeView, placeLabel, currentTempLabel, currentConditionImage, highestTempLabel, lowestTempLabel, dailyTableView] {
            addSubview(item)
        }
        
        for item in [infoLabel, dateLabel, timeLabel] {
            timeView.addSubview(item)
        }
    }
    
    override func setConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        placeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        timeView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.trailing.equalToSuperview().inset(30)
            make.size.equalTo(180)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        currentConditionImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.centerX.equalToSuperview()
            make.size.equalTo(50)
        }
        currentTempLabel.snp.makeConstraints { make in
            make.top.equalTo(currentConditionImage.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        dailyTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(currentTempLabel.snp.bottom).offset(30)
            make.height.equalTo(400)
        }
    }
}
