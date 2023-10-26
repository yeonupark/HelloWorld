//
//  MyTravelTabelViewCell.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/26.
//

import UIKit

class MyTravelTableViewCell: UITableViewCell {
    
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = Constant.Color.backgroundColor
        
        return view
    }()
    
    let dateLabel = {
        let view = UILabel()
        view.font = UIFont(name: Constant.FontName.regular, size: 15)
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
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
        contentView.addSubview(backView)
        selectionStyle = .none
        
        backView.addSubview(dateLabel)
        backView.addSubview(titleLabel)
    }
    
    func setConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
        }
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
    }

}
