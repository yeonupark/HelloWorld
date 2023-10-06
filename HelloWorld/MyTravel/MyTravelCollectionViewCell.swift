//
//  MyTravelCollectionViewCell.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/06.
//

import UIKit

class MyTravelCollectionViewCell: UICollectionViewCell {
    
    let dateLabel = {
        let view = UILabel()
//        view.layer.cornerRadius = 5
//        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "Orange")
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 40)
        view.textAlignment = .center
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    let deleteButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        view.tintColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.backgroundColor = UIColor(named: "MainColor")
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
            make.size.equalTo(30)
        }
    }

}
