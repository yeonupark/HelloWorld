//
//  MyTravelCollectionViewCell.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/06.
//

import UIKit

class MyTravelCollectionViewCell: UICollectionViewCell {
    
    let backView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = Constant.Color.backgroundColor
        view.layer.opacity = 100
       
        return view
    }()
    
    let dateLabel = {
        let view = UILabel()
        view.font = UIFont(name: Constant.FontName.bold, size: 15)
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.textAlignment = .center
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
        contentView.addSubview(backView)
        backView.addSubview(dateLabel)
        backView.addSubview(titleLabel)
        backView.addSubview(deleteButton)
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
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
            make.size.equalTo(30)
        }
    }

}
