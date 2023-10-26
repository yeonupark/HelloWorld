//
//  MyTravelView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/06.
//

import Foundation
import UIKit

class MyTravelView: BaseView {
    
    let backgroundView = {
        let view = UIImageView()
        view.image = UIImage(named: "FishImage")
        view.layer.opacity = 0.7
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    let tableView = {
        let view = UITableView()
        view.register(MyTravelTableViewCell.self, forCellReuseIdentifier: "MyTravelTableViewCell")
        
        view.backgroundColor = .clear
        return view
    }()
    
    let addButton = {
        let view = UIButton()
        view.setTitle("+", for: .normal)
        view.titleLabel?.font = UIFont(name: Constant.FontName.regular, size: 25)
        view.titleLabel?.textColor = .white
        view.backgroundColor = Constant.Color.subColor
        view.layer.cornerRadius = 25
        
        view.clipsToBounds = true
        view.layer.shadowColor = Constant.Color.titleColor?.cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 25
        view.layer.shadowOffset = CGSize.zero
        
        return view
    }()
    
    override func configure() {
        addSubview(backgroundView)
        addSubview(tableView)        
        addSubview(addButton)
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(100)
            make.size.equalTo(50)
        }
    }
}
