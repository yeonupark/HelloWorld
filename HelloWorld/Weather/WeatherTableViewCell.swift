//
//  WeatherTableViewCell.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/12.
//

import Foundation
import UIKit
import SnapKit

class WeatherTableViewCell: UITableViewCell {
    
    let dateLabel = {
        let view = UILabel()
        return view
    }()
    
    let symbolImage = {
        let view = UIImageView()
        return view
    }()
    
    let tempLabel = {
        let view = UILabel()
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.backgroundColor = Constant.Color.backgroundColor
        for item in [dateLabel, symbolImage, tempLabel] {
            contentView.addSubview(item)
        }
    }
    
    func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
        }
        symbolImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(90)
            make.width.equalTo(40)
        }
        tempLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(symbolImage.snp.trailing).offset(30)
        }
    }
}
