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
    
    let infoLabel = {
        let view = UILabel()
        view.backgroundColor = UIColor(named: "Orange")
        view.text = "[ 현재 시간 ]"
        
        return view
    }()
    
    let dateLabel = {
        let view = UILabel()
        view.backgroundColor = UIColor(named: "Orange")
        view.text = "2023-10-12"
        
        return view
    }()
    
    let timeLabel = {
        let view = UILabel()
        view.backgroundColor = UIColor(named: "Orange")
        view.text = "14:28"
        
        return view
    }()
    
    let weatherView = {
        let view = UIView()
        
        return view
    }()
    
    override func configure() {
        backgroundColor = .white
        for item in [placeLabel, infoLabel, dateLabel, timeLabel, weatherView] {
            addSubview(item)
        }
    }
    
    override func setConstraints() {
        placeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
    }
}
